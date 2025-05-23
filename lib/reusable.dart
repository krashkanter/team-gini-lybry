import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lybry/main.dart';
import 'package:lybry/screens/reader.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

toColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "ff$hexColor";
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
            alignment: const Alignment(-0.9, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          )
        ],
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

    if (kDebugMode) {
      print("Fetched data: $data");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error getting documents: $e");
    }
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


      // Store the results
      if (kDebugMode) {
        print(phoneticTranscription);
      }

      wordDetails.add({
        'definition': await askGemini(
                "help a dyslexic person understand the meaning of this word, the words should be vey simple, answer in 1 line: $wordDefinition") ??
            "",

        'phonetic': await askGemini(
                "help a dyslexic person pronounce this word, answer in one word: $word") ??
            "",

        'audio': audioLinks.isNotEmpty
            ? audioLinks[0]
            : '', // You can choose to return all audio links if needed
      });

      return wordDetails; // Return the list of details
    } else {
      throw Exception('Failed to load definition');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }

    return []; // Return an empty list on error
  }
}

String removeSpecialCharacters(String input) {
  final RegExp alphanumericRegex = RegExp(r'[^a-zA-Z0-9]');
  return input.replaceAll(alphanumericRegex, '');
}

Future<void> playAudio(String url) async {
  final player = AudioPlayer();
  player.setReleaseMode(ReleaseMode.stop);

  // Start the player as soon as the app is displayed.
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await player.setSource(UrlSource(url));
    await player.resume();
  });
}

Widget reusableTextField(String text, TextEditingController controller) {
  return TextField(
    controller: controller,
    cursorColor: textC,
    cursorWidth: 2,
    cursorHeight: 20,
    style: TextStyle(color: textC, fontSize: 24, fontWeight: FontWeight.w900),
    maxLines: null,
    decoration: InputDecoration(
      labelText: text,
      labelStyle:
          TextStyle(color: textC, fontWeight: FontWeight.bold, fontSize: 20),
      filled: false,
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    keyboardType:
        TextInputType.multiline, // Change to multiline for non-password fields
  );
}
