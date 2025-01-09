import 'package:flutter/material.dart';
import 'package:fetch_api_programming_jokes/joke_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Programming Jokes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JokeScreen(),
    );
  }
}
