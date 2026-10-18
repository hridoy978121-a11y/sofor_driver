import 'package:flutter/material.dart';

class RideRequestCard extends StatelessWidget {
  const RideRequestCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(padding: const EdgeInsets.all(12),
        child: Column(children: [
          const Text("New Ride - 742 Oak Street", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Fare: \$18.50 - 2.3 mi"),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            OutlinedButton(onPressed: (){}, child: const Text("Decline")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00A86B)),
              onPressed: (){}, 
              child: const Text("Accept", style: TextStyle(color: Colors.white))
            ),
          ])
        ]),
      ),
    );
  }
}