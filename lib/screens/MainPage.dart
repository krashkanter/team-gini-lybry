import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahyadri_hacknight/reusable.dart';
import 'package:sahyadri_hacknight/screens/Library.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: toColor("fff6e5"),
      body: Stack(
        children: [
          Align(
              alignment: const Alignment(0, -0.5),
              child: logoWidget("assets/LyBry-Transparent.png", 300, 300)),
          const Align(
              alignment: Alignment(0, -0.05),
              child: Text(
                "LyBry",
              )),
          Align(
            alignment: Alignment(0, 1),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Library()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: toColor("56C0A1"),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(200),
                        topRight: Radius.circular(200)), // Rounded corners
                  ),
                  width: 300,
                  height: 300,
                )),
          )
        ],
      ),
    );
  }
}
