import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'finish_screen.dart';

class TripRunningScreen extends StatefulWidget {
  final String tripId;
  final Map<String, dynamic> tripData;
  const TripRunningScreen({super.key, required this.tripId, required this.tripData});
  @override
  State<TripRunningScreen> createState() => _TripRunningScreenState();
}

class _TripRunningScreenState extends State<TripRunningScreen> {
  bool isStarted = false;

  void finishTrip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => FinishScreen(fare: widget.tripData['fare']?? 120)),
    );
  }

  void startTrip() {
    setState(() => isStarted = true);
  }

  @override
  Widget build(BuildContext context) {
    final lat = (widget.tripData['pickupLat']?? 23.8103).toDouble();
    final lng = (widget.tripData['pickupLng']?? 90.4125).toDouble();
    final fare = widget.tripData['fare']?? 120;

    Widget mapWidget = kIsWeb
       ? Container(
            color: Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 80, color: Colors.grey[600]),
                  const SizedBox(height: 10),
                  Text("Map Preview\n$lat, $lng", textAlign: TextAlign.center),
                  const Text("(Android phone e live map dekhabe)", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          )
        : GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 15));

    return Scaffold(
      appBar: AppBar(title: Text(isStarted? "Trip Cholche" : "যাত্রীর কাছে যান"), backgroundColor: Colors.blue),
      body: Stack(children: [
        mapWidget,
        Positioned(
          bottom: 20, left: 20, right: 20,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text("মিরপুর 10 থেকে ধানমন্ডি", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("ভাড়া: $fare টাকা"),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isStarted? finishTrip : startTrip,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.all(16)),
                    child: Text(isStarted? "FINISH TRIP" : "START TRIP",
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}