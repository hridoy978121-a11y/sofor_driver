import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const SoforDriverApp());
}

class SoforDriverApp extends StatelessWidget {
  const SoforDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sofor Driver',
      theme: ThemeData(
        primaryColor: Color(0xFF00A86B),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00A86B)),
      ),
      home: SplashScreen(),
    );
  }
}