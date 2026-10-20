import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/language_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2E1F),
        elevation: 0,
        title: Text(langProvider.t('settings'),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // LANGUAGE CHANGE CARD
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    // EKHANE THIK KORE DILAM - CROSS AR ASBE NA
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E9E62).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.translate_rounded, color: Color(0xFF1E9E62), size: 22),
                    ),
                    title: Text(langProvider.t('language'),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text(
                        langProvider.lang == 'bn' ? 'বাংলা' : 'English',
                        style: const TextStyle(color: Colors.grey)),
                  ),
                  const Divider(height: 1),
                  
                  // Bangla Option
                  RadioListTile<String>(
                    value: 'bn',
                    groupValue: langProvider.lang,
                    activeColor: const Color(0xFF1E9E62),
                    title: Row(
                      children: [
                        const Text("বাংলা ",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        Text("(Bengali)",
                            style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                    onChanged: (val) {
                      if (val != null) {
                        langProvider.setLang(val);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("ভাষা বাংলা করা হয়েছে"), backgroundColor: Color(0xFF0A2E1F)),
                        );
                      }
                    },
                  ),

                  // English Option
                  RadioListTile<String>(
                    value: 'en',
                    groupValue: langProvider.lang,
                    activeColor: const Color(0xFF1E9E62),
                    title: Row(
                      children: [
                        const Text("English ",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        Text("(English)",
                            style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                    onChanged: (val) {
                      if (val != null) {
                        langProvider.setLang(val);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Language changed to English"), backgroundColor: Color(0xFF0A2E1F)),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  side: const BorderSide(color: Colors.black26),
                ),
                onPressed: () {},
                child: Text(langProvider.t('logout'),
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
              ),
            )
          ],
        ),
      ),
    );
  }
}