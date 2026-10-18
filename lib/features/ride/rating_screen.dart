import 'package:flutter/material.dart';
class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Rate Passenger")), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (i)=> Icon(Icons.star, size: 40, color: Colors.orange))), SizedBox(height: 20), ElevatedButton(onPressed: (){ Navigator.pop(context); }, child: Text("Submit 5 Star"))])));
  }
}