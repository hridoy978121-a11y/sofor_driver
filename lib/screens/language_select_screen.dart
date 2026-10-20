import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/language_provider.dart';
import 'settings_screen.dart'; // eita add koren
// import 'driver_home_page.dart'; // apnar home page import

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  String selected = 'en';

  @override
  void initState() {
    super.initState();
    final lang = Provider.of<LanguageProvider>(context, listen: false).lang;
    selected = lang;
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0A2E1F),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 80),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset('assets/images/bike_car.png',
                      width: double.infinity, height: 220, fit: BoxFit.cover),
                ),
                const SizedBox(height: 30),
                Text(langProvider.t('welcome'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 8),
                Text(langProvider.t('subtitle'),
                    style: const TextStyle(fontSize: 14, color: Color(0xFFB2DFDB))),
                const SizedBox(height: 30),

                // BANGLA BUTTON
                GestureDetector(
                  onTap: () {
                    setState(() => selected = 'bn');
                    langProvider.setLang('bn');
                  },
                  child: Container(
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: selected == 'bn'
                              ? const Color(0xFF2ECC71)
                              : Colors.white30,
                          width: 1.5),
                      borderRadius: BorderRadius.circular(14),
                      color: selected == 'bn'
                          ? const Color(0x1A2ECC71)
                          : Colors.white.withOpacity(0.08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(langProvider.t('bangla'),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(width: 8),
                        const Text("(Bengali)",
                            style:
                                TextStyle(fontSize: 12, color: Colors.white60)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ENGLISH BUTTON
                GestureDetector(
                  onTap: () {
                    setState(() => selected = 'en');
                    langProvider.setLang('en');
                  },
                  child: Container(
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: selected == 'en'
                              ? const Color(0xFF2ECC71)
                              : Colors.white30,
                          width: 1.5),
                      borderRadius: BorderRadius.circular(14),
                      color: selected == 'en'
                          ? const Color(0x1A2ECC71)
                          : Colors.white.withOpacity(0.08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(langProvider.t('english'),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(width: 8),
                        const Text("(English)",
                            style:
                                TextStyle(fontSize: 12, color: Colors.white60)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E9E62),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () async {
                      await langProvider.setLang(selected);
                      if (!mounted) return;
                      // TODO: Apnar Login/Home page e niye jan
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DriverHomePage()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Language set to: $selected")),
                      );
                    },
                    child: Text(langProvider.t('continue'),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 12),

                // THIK KORA PART - EKHON PRESS KORLE KAJ KORBE
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  },
                  child: Text(langProvider.t('change_later'),
                      style: TextStyle(
                          fontSize: 12, 
                          color: Colors.white54,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white54
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}