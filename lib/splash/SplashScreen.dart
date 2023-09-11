import 'dart:async';

import 'package:flutter/material.dart';

import '../home/Home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});

  final String title;

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Registro de Presença SURAFO',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  void initState() {
    startSplashScreen();
  }
}
