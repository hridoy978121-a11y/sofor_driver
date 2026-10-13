import 'package:flutter/material.dart';
import 'rating_screen.dart';

class FinishScreen extends StatelessWidget {
  final int fare;
  const FinishScreen({super.key, required this.fare});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              const Text("Trip Sesh!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Apni peyechen: $fare Taka", style: const TextStyle(fontSize: 20, color: Colors.black87)),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.all(16)),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RatingScreen(fare: fare)));
                  },
                  child: const Text("Taka Bujhe Niyechi", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}