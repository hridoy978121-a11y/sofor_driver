import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'trip_running.dart';

class TripRequestScreen extends StatelessWidget {
  final String tripId;
  final Map<String, dynamic> tripData;
  const TripRequestScreen({super.key, required this.tripId, required this.tripData});

  acceptTrip(BuildContext context) async {
    await FirebaseFirestore.instance.collection('trips').doc(tripId).update({'status': 'accepted'});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TripRunningScreen(tripId: tripId, tripData: tripData)));
  }

  rejectTrip() async {
    await FirebaseFirestore.instance.collection('trips').doc(tripId).update({'status': 'rejected'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Notun Trip Request!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(title: Text("From: ${tripData['pickupAddress']}"), subtitle: Text("To: ${tripData['dropAddress']}")),
            Text("Vara: ${tripData['fare']} TK", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            Row(children: [
              Expanded(child: ElevatedButton(onPressed: () => rejectTrip(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: Text("REJECT"))),
              const SizedBox(width: 10),
              Expanded(child: ElevatedButton(onPressed: () => acceptTrip(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text("ACCEPT"))),
            ])
          ],
        ),
      ),
    );
  }
}