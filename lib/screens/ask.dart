import 'package:flutter/material.dart';
import 'package:sahyadri_hacknight/screens/Reader.dart';
import '../main.dart';
import '../reusable.dart';

class Ask extends StatefulWidget {
  const Ask({super.key});

  @override
  State<Ask> createState() => _AskState();
}

class _AskState extends State<Ask> {
  TextEditingController _text = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgC,
      floatingActionButton: Container(
        width: 70.0, // Set your desired width
        height: 70.0, // Set your desired height
        child: FloatingActionButton(
          onPressed: () async {
            // Get the summarized text from Gemini
            String? summarizedText = await askGemini("Summerize this in very simple Language, dont change the actual text too much just simlify to complex words: ${_text.text}");
            print(summarizedText);

            // Navigate to Reader page with the summarized text
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Reader(
                  title: "Summarized Message",
                  data: summarizedText ?? "Error summarizing text.", // Handle null case
                ),
              ),
            );
          },
          shape: const CircleBorder(),
          backgroundColor: toColor("56C0A1"),
          child: const Icon(
            Icons.add_circle,
            size: 40, // Increase the icon size if needed
          ),
        ),
      ),
      body: Column(
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
                        "Ask",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w900),
                      ),
                    )),
              )),
          Divider(
            color: textC,
            thickness: 6,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: reusableTextField("Enter Text", _text),
          ),
        ],
      ),
    );
  }
}