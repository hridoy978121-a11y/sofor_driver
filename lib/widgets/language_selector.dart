import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/driver_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});
  @override
  Widget build(BuildContext context) {
    final p = context.watch<DriverProvider>();
    return Row(
      children: [
        const Icon(Icons.language),
        const SizedBox(width: 8),
        DropdownButton<String>(
          value: p.languageCode,
          items: const [
            DropdownMenuItem(value: 'bn', child: Text('🇧🇩 বাংলা')),
            DropdownMenuItem(value: 'en', child: Text('🇬🇧 EN')),
          ],
          onChanged: (v){ if(v!=null) p.setLanguage(v); },
        ),
      ],
    );
  }
}