import 'package:flutter/material.dart';
class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Welcome to Sofor"), ElevatedButton(onPressed: (){}, child: Text("Bangla / English"))])));
  }
}