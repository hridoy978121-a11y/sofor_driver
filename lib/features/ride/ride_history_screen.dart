import 'package:flutter/material.dart';
class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Rides - Sofor")), body: ListView.builder(itemCount: 10, itemBuilder: (_, i)=> Card(child: ListTile(leading: Icon(Icons.directions_car), title: Text("Ride #1049$i"), subtitle: Text("Today - Paid - Downtown"), trailing: Text("+\$18.50", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))))));
  }
}