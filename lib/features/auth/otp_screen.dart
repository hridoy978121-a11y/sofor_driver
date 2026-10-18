import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP Verification")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          Icon(Icons.message, size: 60, color: Color(0xFF00A86B)),
          SizedBox(height: 20),
          Text("OTP Code Pathano Hoyeche", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("01XXXXXXXXX number e 6 digit code geche", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 30),
          // 6 ta box er OTP
          TextField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, letterSpacing: 15, fontWeight: FontWeight.bold),
            decoration: InputDecoration(hintText: "123456", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),
          SizedBox(height: 20),
          SizedBox(width: double.infinity, height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A86B)),
              onPressed: (){
                // OTP 123456 hole login hobe
                if(_otpController.text.length == 6){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> HomeScreen()), (route)=> false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("6 digit OTP den")));
                }
              },
              child: Text("Verify OTP - Confirm", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
          SizedBox(height: 15),
          TextButton(onPressed: (){}, child: Text("OTP Abar Pathan - Resend")),
          SizedBox(height: 10),
          Text("Demo OTP: 123456", style: TextStyle(color: Colors.red)),
        ]),
      ),
    );
  }
}