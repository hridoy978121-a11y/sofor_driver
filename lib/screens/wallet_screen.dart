import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Pore Firebase theke asbe
    double totalEarning = 2450;
    double walletBalance = 2000;
    double companyDue = 450;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Wallet"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1. Sobuj Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Wallet Balance", style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 5),
                  Text("৳ $walletBalance", style: const TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _smallBox("Total Earn", "৳ $totalEarning"),
                      _smallBox("Company Due", "৳ $companyDue", isDue: true),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. bKash Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(backgroundColor: Colors.pink, child: Icon(Icons.account_balance_wallet, color: Colors.white)),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("bKash Payment", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text("017XXXXXXXX - Sofor Pay", style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Clipboard.setData(const ClipboardData(text: "017XXXXXXXX"));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("bKash Number Copyed!")));
                        },
                        child: const Text("Copy"),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.all(14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Admin ke request pathano hoise!")));
                      },
                      child: const Text("Payment Done Janan", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Note: bKash korar por 'Payment Done' e click korun. Admin approve korle Due 0 hoye jabe.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _smallBox(String title, String value, {bool isDue = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(color: isDue? Colors.yellow : Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}