import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              // 1. Logo
              Image.asset(
                'assets/images/logo.png',
                height: 90,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              // 2. Bike + Car
              Image.asset(
                'assets/images/bike_car.png',
                height: 220,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 40),

              // 3. NEW TEXT - EKHANE VUL CHILO
              const Text(
                "Welcome to Sofor Ride.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Delivery, Arrived on Time.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 30),

              // Bangla Button
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF0F5D2E), width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFE8F5E9),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("🇧🇩"),
                    SizedBox(width: 10),
                    Text("বাংলা", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // English Button
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("🇬🇧"),
                    SizedBox(width: 10),
                    Text("English", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const Spacer(),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F5D2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}