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
  late List<String> words;
  int currentIndex = 0;
  static const int wordsPerPage = 20; // Number of words to display at a time

  @override
  void initState() {
    super.initState();
    // Split the string into words
    words = widget.data.split(' ');
  }

  void nextPage() {
    setState(() {
      if (currentIndex + wordsPerPage < words.length) {
        currentIndex += wordsPerPage;
      }
    });
  }

  void previousPage() {
    setState(() {
      if (currentIndex - wordsPerPage >= 0) {
        currentIndex -= wordsPerPage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the words to display based on the current index
    List<String> displayedWords =
        words.skip(currentIndex).take(wordsPerPage).toList();

    return Scaffold(
      backgroundColor: bgC,
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 100,
        backgroundColor: bgC,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: StoryContainer(
                  words: displayedWords,
                  onWordTap: (word) {
                    print(word);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: currentIndex > 0 ? previousPage : null,
                      child: Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: currentIndex + wordsPerPage < words.length
                          ? nextPage
                          : null,
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment(-1, 1),
            child: GestureDetector(
              onTap: currentIndex + wordsPerPage < words.length
                  ? previousPage
                  : null,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: toColor("333A3F"), width: 5),
                    color: toColor("56C0A1"),
                    borderRadius: BorderRadius.circular(1000)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment(1, 1),
            child: GestureDetector(
              onTap:
                  currentIndex + wordsPerPage < words.length ? nextPage : null,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: toColor("333A3F"), width: 5),
                    color: toColor("56C0A1"),
                    borderRadius: BorderRadius.circular(1000)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class StoryContainer extends StatelessWidget {
  final List<String> words;
  final ValueChanged<String> onWordTap;

  StoryContainer({required this.words, required this.onWordTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
              onTap: () => onWordTap(word),
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
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
