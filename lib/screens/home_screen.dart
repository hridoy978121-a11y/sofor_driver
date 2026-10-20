import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../provider/language_provider.dart';
import 'settings_screen.dart'; // settings screen import

class DriverHomePage extends StatefulWidget {
  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  bool isOnline = false;
  
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: Stack(children: [
        FlutterMap(
          options: MapOptions(initialCenter: LatLng(23.8103, 90.4125), initialZoom: 13),
          children: [
            TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.sofor.driver'),
            MarkerLayer(markers: [Marker(point: LatLng(23.8103, 90.4125), child: Icon(Icons.location_pin, size: 50, color: Color(0xFF00A86B)))]),
          ],
        ),
        // Top Card - Online / Offline
        Positioned(
          top: 50, left: 20, right: 20,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(isOnline ? lang.t('you_online') : lang.t('you_offline'), style: TextStyle(fontWeight: FontWeight.bold)),
                Text(isOnline ? lang.t('finding_passengers') : lang.t('go_online_to_earn'), style: TextStyle(color: Colors.grey, fontSize: 12)),
              ]),
              Row(
                children: [
                  Switch(value: isOnline, activeColor: Color(0xFF00A86B), onChanged: (v) => setState(() => isOnline = v)),
                  // Settings Icon - Language Change
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.black54),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
                    },
                  ),
                ],
              ),
            ]),
          ),
        ),
        // Bottom Card
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(children: [Text(lang.t('today_earn'), style: TextStyle(color: Colors.grey)), Text("\$ 0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]),
                Column(children: [Text(lang.t('trips'), style: TextStyle(color: Colors.grey)), Text("0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]),
                Column(children: [Text(lang.t('rating'), style: TextStyle(color: Colors.grey)), Text("5.0 ★", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]),
              ]),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A86B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: () {},
                  child: Text(isOnline ? lang.t('waiting_request') : lang.t('go_online_btn'), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}