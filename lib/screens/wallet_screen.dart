import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  static const String bkashNumber = "01766562165";
  static const String nagadNumber = "01766562165";

  double walletBalance = 0;
  double companyDue = 450;
  bool isLoading = false;
  String driverPhoneFromDb = "";
  String driverIdForDb = "test_driver_id";

  @override
  void initState() {
    super.initState();
    _loadDriverData();
  }

  Future<void> _loadDriverData() async {
    final user = FirebaseAuth.instance.currentUser;
    // User থাকলে তার UID, না থাকলে test_driver_id
    String docId = user?.uid ?? "test_driver_id";
    driverIdForDb = docId;

    try {
      final doc = await FirebaseFirestore.instance.collection("drivers").doc(docId).get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          walletBalance = (data['walletBalance'] ?? 0).toDouble();
          companyDue = (data['companyDue'] ?? 450).toDouble();
          // phone field 2 নামে থাকতে পারে, 2টাই চেক করবে
          driverPhoneFromDb = data['phone'] ?? data['phoneNumber'] ?? data['mobile'] ?? user?.phoneNumber ?? "";
        });
      } else {
        // Document না থাকলে Auth থেকে নিবে
        setState(() {
          driverPhoneFromDb = user?.phoneNumber ?? "";
        });
      }
    } catch (e) {
      debugPrint("Driver load error: $e");
    }
  }

  Future<void> _showPaymentDialog() async {
    String selectedMethod = "bKash";
    final amountCtrl = TextEditingController(text: companyDue.toString());
    final trxCtrl = TextEditingController();
    // যদি DB থেকে ফোন না পায়, তাহলে ইউজারকে ফোন লিখতে বলবে
    final phoneCtrl = TextEditingController(text: driverPhoneFromDb);

    return showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: const Text("Payment Info Din"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text("Send Money to: $bkashNumber\nSofor Pay", textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  value: selectedMethod,
                  items: const [
                    DropdownMenuItem(value: "bKash", child: Text("bKash")),
                    DropdownMenuItem(value: "Nagad", child: Text("Nagad")),
                  ],
                  onChanged: (v) => setSt(() => selectedMethod = v!),
                  decoration: const InputDecoration(labelText: "Method", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(controller: amountCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Amount (৳)", border: OutlineInputBorder())),
                const SizedBox(height: 10),
                // ফোন নাম্বার ফিল্ড - খালি থাকলে দেখাবে
                TextField(
                  controller: phoneCtrl, 
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: "Your Phone Number", border: OutlineInputBorder(), hintText: "01XXXXXXXXX")
                ),
                const SizedBox(height: 10),
                TextField(controller: trxCtrl, decoration: const InputDecoration(labelText: "TrxID", border: OutlineInputBorder(), hintText: "Ex: 8G4T9X2L")),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () async {
                if (trxCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("TrxID দিন")));
                  return;
                }
                if (phoneCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Phone Number দিন")));
                  return;
                }
                Navigator.pop(ctx);
                // ফোন নাম্বারটা save করে রাখলাম
                setState(() => driverPhoneFromDb = phoneCtrl.text.trim());
                await _sendRequestToFirebase(selectedMethod, amountCtrl.text, trxCtrl.text.trim(), phoneCtrl.text.trim());
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendRequestToFirebase(String method, String amount, String trxId, String phone) async {
    setState(() => isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      
      await FirebaseFirestore.instance.collection("payment_requests").add({
        "driverId": user?.uid ?? driverIdForDb,
        "driverName": user?.displayName ?? "Sofor Driver",
        "driverPhone": phone, // এখন ১০০% আসবে, খালি না
        "method": method,
        "amount": double.tryParse(amount) ?? 0,
        "trxId": trxId,
        "status": "pending",
        "createdAt": FieldValue.serverTimestamp(),
        "bkashNumber": bkashNumber,
        "nagadNumber": nagadNumber,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request Admin er kache geche! Approve er jonno wait korun."), backgroundColor: Colors.green));
      }
    } catch (e) {
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red));
    }
    setState(() => isLoading = false);
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
            _paymentBox(context, color: Colors.pink, title: "bKash Payment", number: bkashNumber),
            const SizedBox(height: 12),
            _paymentBox(context, color: Colors.orange, title: "Nagad Payment", number: nagadNumber),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
                onPressed: isLoading ? null : _showPaymentDialog,
                child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Payment Done Janan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentBox(BuildContext context, {required Color color, required String title, required String number}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black12)),
      child: Row(children: [
        CircleAvatar(backgroundColor: color, child: const Icon(Icons.wallet, color: Colors.white)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text("$number - Sofor Pay", style: const TextStyle(color: Colors.grey, fontSize: 12))])),
        ElevatedButton(onPressed: () {Clipboard.setData(ClipboardData(text: number)); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$title Copied!")));}, child: const Text("Copy"))
      ]),
    );
  }
  Widget _smallBox(String title, String value, {bool isDue = false}) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)), child: Column(children: [Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)), Text(value, style: TextStyle(color: isDue ? Colors.yellow : Colors.white, fontWeight: FontWeight.bold))]));
  }
}