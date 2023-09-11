import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'splash/SplashScreen.dart';

void main() async {

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SplashScreen',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen(
      title: '',
    );
  }
}
