import 'package:flutter/material.dart';

class LetterDetailsScreen extends StatelessWidget {
  final String title;
  final String date;
  final String type;

  const LetterDetailsScreen({super.key, required this.title, required this.date, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: const Text("Letter Details", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: const Color(0xFFE52D27), borderRadius: BorderRadius.circular(4)),
            child: Text(type, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(date, style: const TextStyle(color: Colors.grey)),
          const Divider(height: 30),
          const Text(
            "প্রিয় ড্রাইভার ভাই,\n\n"
            "আসসালামু আলাইকুম। আশা করি ভালো আছেন।\n\n"
            "আপনাদের জন্য একটি গুরুত্বপূর্ণ নোটিশ। আগামীকাল থেকে আমাদের নতুন নিয়ম কার্যকর হবে। "
            "সবাইকে অবশ্যই হেলমেট পরিধান করতে হবে এবং যাত্রীর সাথে ভালো ব্যবহার করতে হবে।\n\n"
            "এই নিয়ম না মানলে আইডি সাময়িক বন্ধ হয়ে যেতে পারে।\n\n"
            "ধন্যবাদান্তে,\nBike Rental Team",
            style: TextStyle(fontSize: 15, height: 1.6),
          ),
        ],
      ),
    );
  }
}