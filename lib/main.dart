import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/driver_provider.dart';
import 'screens/driver_home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SoforDriverApp());
}

class SoforDriverApp extends StatelessWidget {
  const SoforDriverApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DriverProvider(),
      child: const MaterialApp(debugShowCheckedModeBanner: false, home: DriverHome()),
    );
  }
}