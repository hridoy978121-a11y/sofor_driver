import 'package:flutter/material.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.person_pin_circle, size: 70, color: Color(0xFF00A86B)),
          SizedBox(height: 20),
          Text("Driver Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Text("Enter your mobile number", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 30),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: "Mobile Number", prefixText: "+88 ", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity, height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A86B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(phone: phoneController.text))),
              child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          )
        ]),
      ),
    );
  }
}