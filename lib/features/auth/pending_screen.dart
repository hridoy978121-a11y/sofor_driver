import 'package:flutter/material.dart';
class PendingScreen extends StatelessWidget {
  const PendingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Sofor verification pending - 24 hours", style: TextStyle(fontSize: 18))));
  }
}