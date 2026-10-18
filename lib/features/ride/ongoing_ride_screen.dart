import 'package:flutter/material.dart';
class OngoingRideScreen extends StatelessWidget {
  const OngoingRideScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Sofor - Ongoing")), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Pickup: 742 Oak Street"), Text("Drop: Downtown Plaza"), SizedBox(height: 20), ElevatedButton(onPressed: (){}, child: Text("Arrived")), ElevatedButton(onPressed: (){}, child: Text("Complete Trip"))])));
  }
}