import 'package:flashcards/local.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() async {
  await Data.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Robotostab",
        primarySwatch: Colors.green,
      ),
      home: const Home(),
    );
  }
}
