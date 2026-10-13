import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final trips = [
      {"from": "Mirpur 10", "to": "Dhanmondi", "fare": 120, "rating": 5},
      {"from": "Gulshan", "to": "Banani", "fare": 80, "rating": 4},
      {"from": "Uttara", "to": "Airport", "fare": 150, "rating": 5},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text("Trip History"), backgroundColor: Colors.red),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, i) {
          final t = trips[i];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.history, color: Colors.green),
              title: Text("${t['from']} -> ${t['to']}"),
              subtitle: Text("Rating: ${t['rating']} ⭐"),
              trailing: Text("${t['fare']} Taka", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            ),
          );
        },
      ),
    );
  }
}