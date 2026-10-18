import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';

void main() => runApp(const SoforApp());

class SoforApp extends StatelessWidget {
  const SoforApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sofor Driver',
      theme: ThemeData(primaryColor: const Color(0xFF00A86B)),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF00A86B),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.route, size: 80, color: Colors.white),
          SizedBox(height: 10),
          Text("Sofor", style: TextStyle(fontSize: 42, color: Colors.white, fontWeight: FontWeight.bold)),
          Text("Driver App", style: TextStyle(color: Colors.white)),
        ]),
      ),
    );
  }
}