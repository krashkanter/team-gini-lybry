import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold();
  }
}
