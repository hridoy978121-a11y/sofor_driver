import 'package:flutter/material.dart';
class QuestScreen extends StatelessWidget {
  const QuestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Sofor Quests / Hot Zone")), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.local_fire_department, size: 60, color: Colors.red), Text("Hot Zone - Gulshan", style: TextStyle(fontSize: 20)), Text("Bonus: \$500 for 10 rides")])));
  }
}