import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sahyadri_hacknight/screens/Reader.dart';
import 'package:http/http.dart' as http;

toColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "ff" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

Color bgC = toColor("fff6e5");
Color textC = toColor("333A3F");

Image logoWidget(String imageName, double x, double y) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: x,
    height: y,
  );
}

Widget Book(BuildContext context, String link, String title, String data) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Reader(title: title, data: data)));
    },
    child: Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(link), // Correct usage
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: toColor("333A3F"), width: 5),
                color: toColor("56C0A1"),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Align(
              alignment: Alignment(-0.9, 0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Future<void> getDataFromFirestore(String collectionName) async {
  await Firebase.initializeApp();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    QuerySnapshot querySnapshot =
        await firestore.collection(collectionName).get();

    List<Map<String, dynamic>> data = querySnapshot.docs.map((doc) {
      return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
    }).toList();

    print("Fetched data: $data");
  } catch (e) {
    print("Error getting documents: $e");
  }
}

Future<List<Map<String, String>>> fetchWordDefinition(String word) async {
  word = removeSpecialCharacters(word);
  final url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';

  List<Map<String, String>> wordDetails = [];

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the JSON response

      List<dynamic> wordDefinition = jsonDecode(response.body);

      // Extract details from the response

      String word = wordDefinition[0]['word'];

      // Extract phonetics

      List<dynamic> phoneticsList = wordDefinition[0]['phonetics'];

      String phoneticTranscription =
          phoneticsList.isNotEmpty ? phoneticsList[0]['text'] ?? '' : '';

      // Extract audio links

      List<String> audioLinks = phoneticsList
          .map((phonetic) => phonetic['audio'] as String)
          .where((audio) => audio.isNotEmpty)
          .toList();

      // Extract definitions

      List<dynamic> meanings = wordDefinition[0]['meanings'];

      String definition = '';

      if (meanings.isNotEmpty) {
        definition = meanings[0]['definitions'][0]['definition'] ?? '';
      }

      // Store the results

      wordDetails.add({
        'definition': definition,

        'phonetic': phoneticTranscription,

        'audio': audioLinks.isNotEmpty
            ? audioLinks[0]
            : '', // You can choose to return all audio links if needed
      });

      return wordDetails; // Return the list of details
    } else {
      throw Exception('Failed to load definition');
    }
  } catch (e) {
    print('Error: $e');

    return []; // Return an empty list on error
  }
}

String removeSpecialCharacters(String input) {
  final RegExp alphanumericRegex = RegExp(r'[^a-zA-Z0-9]');
  return input.replaceAll(alphanumericRegex, '');
}
