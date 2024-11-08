import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahyadri_hacknight/reusable.dart';
import 'package:google_fonts/google_fonts.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Align(
            alignment: Alignment(0, 1),
            child: Container(
              color: textC,
              height: MediaQuery.sizeOf(context).height - 120,
            ),
          )
        ],
      ),
    );
  }
}
