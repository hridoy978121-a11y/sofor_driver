import 'dart:ui';
import 'package:flutter/material.dart';
import 'vehicle_info_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpCtrl = TextEditingController();

  void checkOtp() {
    if (otpCtrl.text.trim() == '394073') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const VehicleInfoScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wrong OTP! Use 394073'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A1931),
              Color(0xFF123063),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Verify OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Code sent to ${widget.phone}',
                            style: const TextStyle(color: Colors.white54),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Test OTP: 394073',
                            style: TextStyle(
                              color: Color(0xFF8BE9FF),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: otpCtrl,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            style: const TextStyle(
                              color: Colors.white,
                              letterSpacing: 12,
                              fontSize: 22,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: '------',
                              hintStyle: const TextStyle(
                                color: Colors.white24,
                                letterSpacing: 12,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8BE9FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: checkOtp,
                              child: const Text(
                                'Verify & Continue',
                                style: TextStyle(
                                  color: Color(0xFF0A1931),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Your OTP is 394073'),
                                ),
                              );
                            },
                            child: const Text(
                              'Resend OTP',
                              style: TextStyle(color: Color(0xFF8BE9FF)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}