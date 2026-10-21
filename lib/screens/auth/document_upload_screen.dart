import 'dart:ui';
import 'package:flutter/material.dart';

class DocumentUploadScreen extends StatelessWidget {
  const DocumentUploadScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0A1931), Color(0xFF123063)])),
        child: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: ClipRRect(borderRadius: BorderRadius.circular(26), child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25), child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white.withOpacity(0.07), borderRadius: BorderRadius.circular(26), border: Border.all(color: Colors.white.withOpacity(0.14))), child: Column(children: [
          const Text("Upload Documents", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _box("NID Front"), _box("NID Back"), _box("License Front"), _box("License Back"), _box("Vehicle Registration"), _box("Vehicle Photo"), _box("Driver Selfie"),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8BE9FF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Submitted! Admin will verify"))); Navigator.popUntil(context, (r)=> r.isFirst); }, child: const Text("Submit for Verification", style: TextStyle(color: Color(0xFF0A1931), fontWeight: FontWeight.bold)))),
        ])))))),
      ),
    );
  }
  static Widget _box(String t)=> Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(0.15))), child: Row(children: [const Icon(Icons.upload_file, color: Color(0xFF8BE9FF)), const SizedBox(width: 12), Expanded(child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 13))), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: const Color(0xFF8BE9FF), borderRadius: BorderRadius.circular(20)), child: const Text("Upload", style: TextStyle(color: Color(0xFF0A1931), fontSize: 12, fontWeight: FontWeight.bold)))]));
}