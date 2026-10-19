import 'package:flutter/material.dart';
import 'login_screen.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  String selectedLang = "Bangla";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/images/bike_car.png",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 35),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    _langButton(flag: "🇧🇩", title: "বাংলা", value: "Bangla"),
                    const SizedBox(height: 12),
                    _langButton(flag: "🇬🇧", title: "English", value: "English"),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0F5D2E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        // ✅✅✅ EKHANE ADD KORA HOYECHE ✅✅✅
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
builder: (context) => LoginScreen(),                            ),
                          );
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "You can change this later in settings",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _langButton({required String flag, required String title, required String value}) {
    bool isSelected = selectedLang == value;
    return GestureDetector(
      onTap: () => setState(() => selectedLang = value),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF0F5D2E) : Colors.grey.shade300,
            width: isSelected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(flag, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.black : Colors.black87,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 12),
              const Text("✓", style: TextStyle(color: Color(0xFF0F5D2E), fontSize: 20, fontWeight: FontWeight.bold)),
            ]
          ],
        ),
      ),
    );
  }
}