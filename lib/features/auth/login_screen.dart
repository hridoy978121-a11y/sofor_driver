import 'package:flutter/material.dart';
import 'otp_screen.dart'; // OTP page e jabe

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sofor Login"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.route, size: 60, color: Color(0xFF00A86B)),
            const SizedBox(height: 10),
            const Text("Sofor Driver", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Text("Bangladesh e Pathao er moto ride share", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: "01XXXXXXXXX",
                prefixText: "+88 ",
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A86B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: (){
                  if(phoneController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Phone number din")));
                  } else {
                    // OTP Page e niye jabe
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const OtpScreen()));
                  }
                },
                child: const Text("Send OTP - OTP Pathan", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 15),
            const Center(child: Text("Demo te jekono number dilei OTP asbe", style: TextStyle(color: Colors.grey, fontSize: 12))),
          ],
        ),
      ),
    );
  }
}