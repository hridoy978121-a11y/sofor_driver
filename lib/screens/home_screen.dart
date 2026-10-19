import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DriverHomePage extends StatefulWidget {
  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  bool isOnline = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FlutterMap(
          options: MapOptions(initialCenter: LatLng(23.8103, 90.4125), initialZoom: 13),
          children: [
            TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.sofor.driver'),
            MarkerLayer(markers: [Marker(point: LatLng(23.8103, 90.4125), child: Icon(Icons.location_pin, size: 50, color: Color(0xFF00A86B)))]),
          ],
        ),
        Positioned(
          top: 50, left: 20, right: 20,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(isOnline ? "You are Online" : "You are Offline", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(isOnline ? "Finding passengers..." : "Go online to earn", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ]),
              Switch(value: isOnline, activeColor: Color(0xFF00A86B), onChanged: (v) => setState(() => isOnline = v)),
            ]),
          ),
        ),
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(children: [Text("Today's Earn", style: TextStyle(color: Colors.grey)), Text("\$ 0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]),
                Column(children: [Text("Trips", style: TextStyle(color: Colors.grey)), Text("0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]),
                Column(children: [Text("Rating", style: TextStyle(color: Colors.grey)), Text("5.0 ★", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]),
              ]),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A86B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: () {},
                  child: Text(isOnline ? "Waiting for request..." : "Go Online", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}