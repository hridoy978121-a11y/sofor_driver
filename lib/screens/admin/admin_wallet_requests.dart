import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminWalletRequestsScreen extends StatelessWidget {
  const AdminWalletRequestsScreen({super.key});

  Future<void> _approveRequest(BuildContext context, String reqId, String driverId, double amount) async {
    // Confirmation Dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Approve Payment?"),
        content: Text("Driver কে ৳$amount Approve করবেন?\nতার Company Due থেকে $amount টাকা কেটে যাবে।"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Yes, Approve", style: TextStyle(color: Colors.white))
          ),
        ],
      ),
    );
    if (confirm!= true) return;

    try {
      final batch = FirebaseFirestore.instance.batch();

      final reqRef = FirebaseFirestore.instance.collection("payment_requests").doc(reqId);
      batch.update(reqRef, {
        "status": "approved",
        "approvedAt": FieldValue.serverTimestamp(),
        "approvedBy": "admin"
      });

      final driverRef = FirebaseFirestore.instance.collection("drivers").doc(driverId);
      batch.update(driverRef, {
        // Due থেকে টাকা কমবে, 0 এর নিচে যাবে না
        "companyDue": FieldValue.increment(-amount),
        // Wallet এ যদি টাকা যোগ করতে চাও তাহলে এটা রাখো, না চাইলে লাইনটা কেটে দাও
        // "walletBalance": FieldValue.increment(amount),
      });

      await batch.commit();

      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Approved ৳$amount"), backgroundColor: Colors.green));
      }
    } catch (e) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red));
      }
    }
  }

  Future<void> _rejectRequest(String reqId) async {
    await FirebaseFirestore.instance.collection("payment_requests").doc(reqId).update({
      "status": "rejected",
      "rejectedAt": FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Requests"), backgroundColor: Colors.green, foregroundColor: Colors.white),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("payment_requests").where("status", isEqualTo: "pending").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
            return const Center(child: Text("No pending request ✅"));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, i) {
              final data = docs[i].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text("${data['driverName']?? 'Driver'} - ৳${data['amount']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    "Phone: ${data['driverPhone']}\n${data['method']} | Trx: ${data['trxId']}\nDriverID: ${data['driverId']}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  isThreeLine: true,
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 16)),
                        onPressed: () => _approveRequest(context, docs[i].id, data['driverId'], (data['amount'] as num).toDouble()),
                        child: const Text("Approve", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => _rejectRequest(docs[i].id),
                        child: const Text("Reject", style: TextStyle(color: Colors.red, fontSize: 11)),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}