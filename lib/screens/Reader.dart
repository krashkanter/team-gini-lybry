import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../reusable.dart';

class Reader extends StatefulWidget {
  final String title;
  final String data;

  const Reader({super.key, required this.title, required this.data});

  @override
  State<Reader> createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgC,
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 100,
        backgroundColor: bgC,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: StoryContainer(str: widget.data.substring(0, 100)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: toColor("333A3F"), width: 5),
                  color: bgC,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryContainer extends StatelessWidget {
  final String str;

  StoryContainer({required this.str});

  @override
  Widget build(BuildContext context) {
    // Split the string into words
    List<String> words = str.split(' ');

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF333A3F), width: 5),
        color: bgC, // Replace with your bgC variable
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0, // Space between words
          children: words.map((word) {
            return GestureDetector(
                onTap: () {
                  // Print the word to the console when tapped
                  print(word);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: toColor("000000")
                          .withAlpha(30), // Replace with your bgC variable
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                      child: Text(
                        word,
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                ));
          }).toList(),
        ),
      ),
    );
  }
}
