import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'finish_screen.dart';

class TripRunningScreen extends StatefulWidget {
  final String tripId; final Map<String, dynamic> tripData;
  const TripRunningScreen({super.key, required this.tripId, required this.tripData});
  @override State<TripRunningScreen> createState() => _TripRunningScreenState();
}

class _TripRunningScreenState extends State<TripRunningScreen> {
  bool isStarted = false;
  finishTrip() async {
    await FirebaseFirestore.instance.collection('trips').doc(widget.tripId).update({'status': 'completed'});
    if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FinishScreen(fare: widget.tripData['fare'] ?? 0)));
  }
  startTrip() async {
    await FirebaseFirestore.instance.collection('trips').doc(widget.tripId).update({'status': 'running'});
    setState(() => isStarted = true);
  }
  @override
  Widget build(BuildContext context) {
    final lat = (widget.tripData['pickupLat'] ?? 23.8103).toDouble();
    final lng = (widget.tripData['pickupLng'] ?? 90.4125).toDouble();
    return Scaffold(
      appBar: AppBar(title: Text(isStarted ? "Trip Cholche" : "User er kache jan")),
      body: Stack(children: [
        GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 14)),
        Positioned(bottom: 20, left: 20, right: 20,
          child: ElevatedButton(onPressed: isStarted ? finishTrip : startTrip, style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(18)), child: Text(isStarted ? "FINISH TRIP" : "START TRIP"))),
      ]),
    );
  }
}