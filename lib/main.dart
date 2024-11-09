import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahyadri_hacknight/screens/Library.dart';
import 'package:sahyadri_hacknight/screens/MainPage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Gemini.init(apiKey: 'AIzaSyAaVeKd0iQo-5CKiqsK68fjq_kwl0V1yEY');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mainpage(),
      title: 'LyBry',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.varelaRound().fontFamily,
        primarySwatch: Colors.red,
      ),
    );
  }
}

Future<String?> askGemini(String question) async {

  final gemini = Gemini.instance;


  try {

    final responseStream = gemini.streamGenerateContent(question);

    StringBuffer fullResponse = StringBuffer();


    await for (var response in responseStream) {

      fullResponse.write(response.output); // Collect all parts of the output

    }


    return fullResponse.toString();

  } catch (e) {

    log('streamGenerateContent exception', error: e);

    return 'An error occurred while processing your request.';

  }

}