import 'package:flutter/material.dart';
import 'package:news_app/view/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
          primaryColor: Colors.white, useMaterial3: true),
      home: const LandingPage(),
    );
  }
}
