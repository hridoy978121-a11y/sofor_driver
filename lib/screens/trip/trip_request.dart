import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'trip_running.dart';

class TripRequestScreen extends StatelessWidget {
  final String tripId;
  final Map<String, dynamic> tripData;
  TripRequestScreen({required this.tripId, required this.tripData});

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
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Notun Trip Request!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ListTile(title: Text("From: ${tripData['pickupAddress']}"), subtitle: Text("To: ${tripData['dropAddress']}")),
            Text("Vara: ${tripData['fare']} TK", style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            Row(children: [
              Expanded(child: ElevatedButton(onPressed: () => rejectTrip(), child: Text("REJECT"), style: ElevatedButton.styleFrom(backgroundColor: Colors.red))),
              SizedBox(width: 10),
              Expanded(child: ElevatedButton(onPressed: () => acceptTrip(context), child: Text("ACCEPT"), style: ElevatedButton.styleFrom(backgroundColor: Colors.green))),
            ])
          ],
        ),
      ),
    );
  }
}