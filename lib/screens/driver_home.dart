import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../providers/driver_provider.dart';
import '../core/utils/helpers.dart';
import '../widgets/custom_button.dart';
import '../data/districts.dart';
import '../services/voice_service.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DriverProvider>();
    final trip = provider.currentTrip;
    final districtLatLng = LatLng(provider.selectedDistrict.lat, provider.selectedDistrict.lng);
    final voiceService = VoiceService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("SOFOR - ${provider.selectedDistrict.nameEn}", style: const TextStyle(color: Colors.white, fontSize: 15)),
        actions: [Switch(value: provider.isOnline, activeColor: Colors.white, onChanged: (v) => provider.toggleOnline(v))],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<District>(
                value: provider.selectedDistrict,
                isExpanded: true,
                items: bdDistricts.map((d) => DropdownMenuItem(value: d, child: Text("${d.nameBn} - ${d.nameEn}"))).toList(),
                onChanged: (v) { if(v!=null) provider.setDistrict(v); },
              ),
            ),
          ),
          SizedBox(
            height: 400,
            child: FlutterMap(
              options: MapOptions(initialCenter: districtLatLng, initialZoom: 12),
              children: [
                TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.sofor.driver'),
                MarkerLayer(markers: [Marker(point: districtLatLng, width: 50, height: 50, child: const Icon(Icons.location_pin, color: Colors.red, size: 45))]),
              ],
            ),
          ),
          Container(width: double.infinity, color: Colors.red.shade50, padding: const EdgeInsets.all(8), child: Text("🇧🇩 ${provider.selectedDistrict.nameBn} - ${provider.selectedDistrict.nameEn} ONLINE", textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold))),
          const Spacer(),
          if (trip != null)
            Card(
              margin: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(children: [
                  Text("📍 Pickup: ${trip.pickup}"),
                  Text("🎯 Drop: ${trip.drop}"),
                  const SizedBox(height: 5),
                  Text(formatTaka(trip.fare), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(child: CustomButton(text: 'বাতিল', color: Colors.grey, onTap: provider.rejectTrip)),
                    const SizedBox(width: 10),
                    Expanded(child: CustomButton(text: 'গ্রহণ', color: Colors.red, onTap: provider.acceptTrip)),
                  ])
                ]),
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          bool ok = await voiceService.init();
          if(!ok) return;
          voiceService.listen(onResult: (text){
            if(text.contains("গ্রহণ") || text.contains("grihon") || text.contains("accept")){
              provider.acceptTrip();
              voiceService.speak("ট্রিপ গ্রহণ করা হয়েছে");
            } else if(text.contains("বাতিল") || text.contains("batil") || text.contains("cancel")){
              provider.rejectTrip();
              voiceService.speak("ট্রিপ বাতিল করা হয়েছে");
            }
          });
        }, 
        icon: const Icon(Icons.mic), 
        label: const Text("বাংলায় বলুন")
      ),
    );
  }
}