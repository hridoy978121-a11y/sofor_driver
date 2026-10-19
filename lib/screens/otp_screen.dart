import 'package:flutter/material.dart';
import 'home_screen.dart';

class OtpScreen extends StatelessWidget {
  final String phone;
  OtpScreen({required this.phone});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(children: [
          Text("OTP sent to $phone", textAlign: TextAlign.center),
          SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            maxLength: 4,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, letterSpacing: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(hintText: "----", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity, height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A86B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => DriverHomePage()), (r) => false),
              child: Text("Verify", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          )
        ]),
      ),
    );
  }
}