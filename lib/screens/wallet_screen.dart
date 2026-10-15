import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sofor_driver/widgets/free_offer_banner.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double walletBalance = 0;
  double companyDue = 0; // Ekhon 0, karon commission nai
  String driverPhoneFromDb = "";
  String driverIdForDb = "test_driver_id";

  @override
  void initState() {
    super.initState();
    _loadDriverData();
  }

  Future<void> _loadDriverData() async {
    final user = FirebaseAuth.instance.currentUser;
    String docId = user?.uid ?? "test_driver_id";
    driverIdForDb = docId;

    try {
      final doc = await FirebaseFirestore.instance.collection("drivers").doc(docId).get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          walletBalance = (data['walletBalance'] ?? 0).toDouble();
          companyDue = (data['companyDue'] ?? 0).toDouble();
          driverPhoneFromDb = data['phone'] ?? data['phoneNumber'] ?? data['mobile'] ?? user?.phoneNumber ?? "";
        });
      }
    } catch (e) {
      debugPrint("Driver load error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("My Wallet"), backgroundColor: Colors.green, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // FREE BANNER
            FreeOfferBanner(),
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Wallet Balance", style: TextStyle(color: Colors.white70)),
                  Text("৳ $walletBalance", style: const TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    _smallBox("Total Earn", "৳ 2450"),
                    _smallBox("Company Due", "৳ $companyDue", isDue: true),
                  ])
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Chaile ekhane Earning history add korte parbo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: const Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 40),
                  SizedBox(height: 8),
                  Text("কোন কমিশন কাটা হবে না", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("100% টাকা আপনার", style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _smallBox(String title, String value, {bool isDue = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        Text(value, style: TextStyle(color: isDue ? Colors.yellow : Colors.white, fontWeight: FontWeight.bold))
      ]),
    );
  }
}