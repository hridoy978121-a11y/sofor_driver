import 'package:flutter/material.dart';
import 'language_select_screen.dart'; // apnar final language page

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 2 second por Language Screen e jabe
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LanguageSelectScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Apnar original logo
            Image.asset('assets/images/logo.png', width: 140, height: 140),
            SizedBox(height: 20),
            Text(
              "Sofor Rides",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0B4D2F)),
            ),
            SizedBox(height: 10),
            Text(
              "سفر",
              style: TextStyle(fontSize: 22, color: Color(0xFF0B4D2F)),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(color: Color(0xFF00A86B)),
          ],
        ),
      ),
    );
  }
}