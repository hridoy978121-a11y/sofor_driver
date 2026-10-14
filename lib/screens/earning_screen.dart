import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/earning_provider.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final earning = Provider.of<EarningProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text("Amar Aay"), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text("Mote Aay", style: TextStyle(color: Colors.white, fontSize: 16)),
                      const SizedBox(height: 10),
                      Text("${earning.totalEarnings} Taka", 
                          style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [const Text("Ajker Aay"), const SizedBox(height: 5), Text("${earning.todayEarnings} Taka", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]),
                Column(children: [const Text("Mote Trip"), const SizedBox(height: 5), Text("${earning.totalTrips} Trip", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]),
              ],
            )
          ],
        ),
      ),
    );
  }
}