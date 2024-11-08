import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahyadri_hacknight/reusable.dart';

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
              alignment: Alignment(0, -0.5),
              child: logoWidget("assets/LyBry-Transparent.png", 300, 300)),
        ],
      ),
    );
  }
}
