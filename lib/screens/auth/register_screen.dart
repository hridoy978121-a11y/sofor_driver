import 'dart:ui';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscure1 = true;
  bool obscure2 = true;
  bool remember = true;
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF07132A), Color(0xFF102A5A), Color(0xFF0A1931)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // LOGO - same as login
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/images/sofor_logo.png", height: 48, errorBuilder: (_,__,___)=> const Icon(Icons.local_taxi, color: Colors.yellow)),
                          const SizedBox(width: 10),
                          const Text("SOFOR\nDRIVER", style: TextStyle(color: Color(0xFFA8E6FF), fontWeight: FontWeight.bold, fontSize: 20, height: 0.9)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // REGISTER CARD - same style
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(child: Text("Welcome to Sofor Rider", style: TextStyle(color: Color(0xFFC8F0FF), fontWeight: FontWeight.bold, fontSize: 20))),
                          const SizedBox(height: 4),
                          const Center(child: Text("Create your Sofor driver account", style: TextStyle(color: Colors.white54, fontSize: 12))),
                          const SizedBox(height: 18),
                          
                          _label("Full Name"),
                          _field(Icons.person_outline, "John Doe", nameCtrl, false),
                          const SizedBox(height: 12),
                          
                          _label("Phone Number"),
                          _field(Icons.phone_outlined, "+880 1XXX-XXXXXX", phoneCtrl, false),
                          const SizedBox(height: 12),
                          
                          _label("Password"),
                          _field(Icons.lock_outline, "........", passCtrl, true, isFirst: true),
                          const SizedBox(height: 12),
                          
                          _label("Confirm Password"),
                          _field(Icons.lock_outline, "........", confirmCtrl, true, isFirst: false),

                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Checkbox(
                                value: remember, 
                                onChanged: (v)=>setState(()=>remember=v!),
                                activeColor: const Color(0xFF8BE9FF),
                                side: BorderSide(color: Colors.white.withOpacity(0.5)),
                              ),
                              const Text("Remember me", style: TextStyle(color: Colors.white70, fontSize: 12)),
                              const Spacer(),
                              TextButton(onPressed: (){}, child: const Text("Forgot Password?", style: TextStyle(color: Color(0xFF8BE9FF), fontSize: 12, fontWeight: FontWeight.bold))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity, height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8BE9FF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account Created! Go to Login")));
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const LoginScreen()));
                              },
                              child: const Text("Register", style: TextStyle(color: Color(0xFF0A1931), fontWeight: FontWeight.bold, fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text("Already have an account?", style: TextStyle(color: Colors.white60, fontSize: 13)),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                  child: const Text("Login Now", style: TextStyle(color: Color(0xFF8BE9FF), fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)));
  
  Widget _field(IconData icon, String hint, TextEditingController ctrl, bool isPass, {bool isFirst = true}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.10), borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white.withOpacity(0.18))),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF8BE9FF), size: 18),
              const SizedBox(width: 10),
              Expanded(child: TextField(controller: ctrl, obscureText: isPass ? (isFirst ? obscure1 : obscure2) : false, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Color(0xFFA8D8FF)), border: InputBorder.none))),
              if(isPass) GestureDetector(onTap: ()=>setState(()=> isFirst ? obscure1=!obscure1 : obscure2=!obscure2), child: Icon((isFirst?obscure1:obscure2)?Icons.visibility_outlined:Icons.visibility_off_outlined, color: Colors.white54, size: 20)),
            ],
          ),
        ),
      ),
    );
  }
}