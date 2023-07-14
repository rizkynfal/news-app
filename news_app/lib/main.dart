import 'package:flutter/material.dart';
import 'package:news_app/view/dashboard_page.dart';
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
          primaryColor: Colors.white, fontFamily: 'Lato', useMaterial3: true),
      home: const LandingPage(),
      routes: <String, WidgetBuilder>{
        '/dashboard': (BuildContext context) => const DashboardPage(),
      },
    );
  }
}
