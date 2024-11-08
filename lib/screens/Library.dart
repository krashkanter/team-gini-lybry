import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:sahyadri_hacknight/reusable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahyadri_hacknight/screens/ask.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<Map<String, dynamic>> books = []; // Variable to store fetched data

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Fetch books when the widget is initialized
  }

  Future<void> fetchBooks() async {
    try {
      // Reference to Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetching the collection
      QuerySnapshot querySnapshot = await firestore.collection('books').get();

      // Extracting data from the documents
      List<Map<String, dynamic>> fetchedBooks = querySnapshot.docs.map((doc) {
        return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
      }).toList();

      // Update the state with the fetched data
      setState(() {
        books = fetchedBooks;
      });
    } catch (e) {
      print("Error getting documents: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 70.0, // Set your desired width
        height: 70.0, // Set your desired height
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Ask()));
          },
          shape: const CircleBorder(),
          backgroundColor: toColor("56C0A1"),
          child: const Icon(
            Icons.note,
            size: 30, // Increase the icon size if needed
          ),
        ),
      ),
      backgroundColor: bgC,
      body: Stack(
        children: [
          Align(
              alignment: const Alignment(0, -1),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 120,
                child: const Align(
                    alignment: Alignment(-1, 1),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        "Books",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w900),
                      ),
                    )),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Divider(
              color: textC,
              thickness: 6,
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Container(
              color: Colors.transparent,
              height: MediaQuery.sizeOf(context).height - 130,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: books.map((book) {
                    // Use null-aware operators to handle potential null values
                    final link = book['link'];
                    final title = book['title'] ??
                        'Untitled'; // Default to 'Untitled' if null
                    return Book(context, link, title, book['text']);
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
