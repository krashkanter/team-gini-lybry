import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sahyadri_hacknight/screens/Reader.dart';

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
