import 'dart:ui';
import 'package:flutter/material.dart';

class VehicleInfoScreen extends StatefulWidget {
  const VehicleInfoScreen({super.key});

  @override
  State<VehicleInfoScreen> createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  String selectedType = 'Truck';
  final brandCtrl = TextEditingController();
  final modelCtrl = TextEditingController();
  final yearCtrl = TextEditingController(text: '2022');
  final plateCtrl = TextEditingController();
  final licenseCtrl = TextEditingController();

  final List<Map<String, dynamic>> vehicleTypes = [
    {'name': 'Bike', 'icon': Icons.two_wheeler},
    {'name': 'Car', 'icon': Icons.directions_car},
    {'name': 'CNG', 'icon': Icons.electric_rickshaw}, // CNG er jonno best icon
    {'name': 'Hilux', 'icon': Icons.local_shipping}, // Hilux / Truck
  ];

  Widget buildInput(String label, String hint, TextEditingController ctrl, {String? hint2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint2 ?? hint,
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.white.withOpacity(0.08),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A1931), Color(0xFF123063), Color(0xFF0A1931)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text("Vehicle Information",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
                      const SizedBox(height: 20),
                      const Text("Vehicle Type",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                      const SizedBox(height: 10),
                      // Bike Car CNG Hilux with Icons
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: vehicleTypes.map((v) {
                          bool isSelected = selectedType == v['name'];
                          return GestureDetector(
                            onTap: () => setState(() => selectedType = v['name']),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF8BE9FF) : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white.withOpacity(0.3)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isSelected) const Icon(Icons.check, size: 18, color: Color(0xFF0A1931)),
                                  if (isSelected) const SizedBox(width: 6),
                                  Icon(v['icon'], size: 20, color: const Color(0xFF0A1931)),
                                  const SizedBox(width: 6),
                                  Text(v['name'],
                                      style: const TextStyle(
                                          color: Color(0xFF0A1931), fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      buildInput("Vehicle Brand", "Ex: Yamaha", brandCtrl),
                      const SizedBox(height: 16),
                      buildInput("Vehicle Model", "Ex: FZ-S V2", modelCtrl),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: buildInput("Year", "2022", yearCtrl)),
                          const SizedBox(width: 12),
                          Expanded(child: buildInput("Plate Number", "DHAKA-MET...", plateCtrl, hint2: "DHAKA-MET...")),
                        ],
                      ),
                      const SizedBox(height: 16),
                      buildInput("License Number", "DL-XXXX", licenseCtrl),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8BE9FF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {
                            // Next screen e jabe
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Selected: $selectedType')),
                            );
                          },
                          child: const Text("Next - Upload Documents",
                              style: TextStyle(
                                  color: Color(0xFF0A1931), fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}