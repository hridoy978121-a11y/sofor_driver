import 'package:flutter/material.dart';
class VehicleSelectScreen extends StatelessWidget {
  const VehicleSelectScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Vehicle")),
      body: GridView.count(crossAxisCount: 2, children: const [
        Card(child: Center(child: Text("Bike"))),
        Card(child: Center(child: Text("Car"))),
        Card(child: Center(child: Text("Cycle"))),
        Card(child: Center(child: Text("Truck"))),
      ]),
    );
  }
}