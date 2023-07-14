import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/view/dashboard_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  // void initState() {
  //   super.initState();
  //   _landingPageTime();
  // }

  // _landingPageTime() {
  //   var duration = const Duration(seconds: 3);
  //   return Timer(duration, navigationToDashboard);
  // }

  // void navigationToDashboard() {
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (BuildContext context) => const DashboardPage()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 7,
                  child: Column(    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/img/newspaper_icon.jpg', width: 300, height: 200,),
                      const SizedBox(height: 80,),
                      const Text(
                        "NewsApp",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
