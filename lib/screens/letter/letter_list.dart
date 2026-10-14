import 'package:flutter/material.dart';
import 'letter_details.dart';

class LetterListScreen extends StatelessWidget {
  const LetterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final letters = [
      {"title": "নতুন ভাড়া আপডেট", "date": "14 Oct 2025", "type": "IMPORTANT"},
      {"title": "ঈদের সময় বোনাস", "date": "12 Oct 2025", "type": "BONUS"},
      {"title": "হেলমেট বাধ্যতামূলক", "date": "10 Oct 2025", "type": "SAFETY"},
      {"title": "ঢাকা-কুমিল্লা রুটে নতুন অফার", "date": "08 Oct 2025", "type": "OFFER"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Company Letters", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: letters.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = letters[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => LetterDetailsScreen(title: item['title']!, date: item['date']!, type: item['type']!)));
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: const Color(0xFFE52D27).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.mail_outline, color: Color(0xFFE52D27)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(item['date']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
                    child: Text(item['type']!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                  const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}