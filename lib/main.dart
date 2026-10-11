import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/driver_provider.dart';
import 'screens/driver_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SoforApp());
}

class SoforApp extends StatelessWidget {
  const SoforApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DriverProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sofor Driver',
        theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'HindSiliguri'),
        home: const DriverHome(),
      ),
    );
  }
}