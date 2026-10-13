import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'trip/trip_running.dart';
import 'trip/history_screen.dart'; // <-- EITA ADD KORLAM

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});
  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  int _index = 1; // request tab open thakbe
  final LatLng dhaka = const LatLng(23.8103, 90.4125);

  void acceptTrip() {
    final demoTripData = {
      'pickupLat': 23.8103,
      'pickupLng': 90.4125,
      'pickupAddress': 'মিরপুর 10 থেকে ধানমন্ডি',
      'fare': 120,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripRunningScreen(
          tripId: 'trip_${DateTime.now().millisecondsSinceEpoch}',
          tripData: demoTripData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mapPage = Stack(
      children: [
        kIsWeb
          ? Container(
                color: Colors.grey[300],
                child: const Center(child: Text("Map Android Phone e dekhabe")),
              )
            : GoogleMap(initialCameraPosition: CameraPosition(target: dhaka, zoom: 13)),
        Positioned(
          top: 20, left: 15, right: 15,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
            child: const Text("ঢাকা - ONLINE", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
          ),
        ),
      ],
    );

    Widget requestPage = Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("নতুন যাত্রী! 1.2km দূরে", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Text("মিরপুর 10 থেকে ধানমন্ডি"),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: () {}, child: const Text("Reject"))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: acceptTrip,
                      child: const Text("ACCEPT", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    // --- EKHANE FIX KORLAM ---
    Widget historyPage = const HistoryScreen(); // Age Column chilo, ekhon HistoryScreen
    // -------------------------

    Widget takaPage = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: const [
          CircleAvatar(radius: 40, child: Icon(Icons.person, size: 50)),
          SizedBox(height: 10),
          Text("ড্রাইভার: Sofor Dhaka", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Card(child: ListTile(title: Text("আজকের আয়"), trailing: Text("450 টাকা"))),
        ],
      ),
    );

    List<Widget> pages = [mapPage, requestPage, historyPage, takaPage];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "হোম"),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin_circle), label: "রিকোয়েস্ট"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "হিস্টোরি"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "আয়"),
        ],
      ),
    );
  }
}