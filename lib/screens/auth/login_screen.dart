import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;
  bool _remember = false;
  final _phoneCtrl = TextEditingController(text: "+880 ");
  final _passCtrl = TextEditingController();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      if(mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      debugPrint("Google error: $e");
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Google error: $e")));
    }
  }

  Future<void> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      if(mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      debugPrint("Apple error: $e");
    }
  }

  Future<void> _handleLogin() async {
    if (_phoneCtrl.text.trim().length < 14) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Phone number sothik din (+880 1XXX...)")));
      return;
    }
    if (_passCtrl.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password 6 digit din")));
      return;
    }
    // Apnar login API / Firebase logic ekhane
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login try: ${_phoneCtrl.text}")));
    // Navigator.pushReplacementNamed(context, '/home');
  }

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
            colors: [Color(0xFF0A1931), Color(0xFF0D2A5A)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(top: -20, left: -20, right: -20, child: Image.asset("assets/images/wave_top.png", errorBuilder: (_, __, ___) => _waveTop())),
            Positioned(bottom: -10, left: -20, right: -20, child: _waveBottom()),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white.withOpacity(0.25)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset("assets/images/sofor_blue_yellow_logo.png", height: 65, errorBuilder: (_, __, ___) => const Icon(Icons.local_taxi, color: Colors.blue, size: 40)),
                              const SizedBox(width: 12),
                              const Text("SOFOR\nDRIVER", style: TextStyle(color: Color(0xFFA8E6FF), fontWeight: FontWeight.bold, fontSize: 22, height: 0.9, letterSpacing: 1.2)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                        child: Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.white.withOpacity(0.18)),
                          ),
                          child: Column(
                            children: [
                              const Text("Welcome Back Driver", style: TextStyle(color: Color(0xFFC8F0FF), fontWeight: FontWeight.bold, fontSize: 20)),
                              const SizedBox(height: 4),
                              const Text("Sign in to continue to your driver account", style: TextStyle(color: Colors.white60, fontSize: 12)),
                              const SizedBox(height: 22),
                              const Align(alignment: Alignment.centerLeft, child: Text("Phone Number", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600))),
                              const SizedBox(height: 8),
                              _glassField(icon: Icons.phone, hint: "+880 1XXX-XXXXXX", controller: _phoneCtrl),
                              const SizedBox(height: 16),
                              const Align(alignment: Alignment.centerLeft, child: Text("Password", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600))),
                              const SizedBox(height: 8),
                              _glassField(icon: Icons.lock, hint: "••••••••", controller: _passCtrl, isPass: true),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  SizedBox(width: 18, height: 18, child: Checkbox(value: _remember, onChanged: (v) => setState(() => _remember = v!), side: BorderSide(color: Colors.white.withOpacity(0.5)), checkColor: Colors.white)),
                                  const SizedBox(width: 6),
                                  const Text("Remember me", style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  const Spacer(),
                                  TextButton(onPressed: () => Navigator.pushNamed(context, '/forgot'), child: const Text("Forgot Password?", style: TextStyle(color: Color(0xFF8BE9FF), fontSize: 12, fontWeight: FontWeight.bold))),
                                ],
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8BE9FF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 10),
                                  onPressed: _handleLogin,
                                  child: const Text("Login", style: TextStyle(color: Color(0xFF0A1931), fontWeight: FontWeight.bold, fontSize: 18)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white.withOpacity(0.2))),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text("or", style: TextStyle(color: Colors.white.withOpacity(0.5)))),
                        Expanded(child: Divider(color: Colors.white.withOpacity(0.2))),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _socialBtn(iconPath: "G", label: "Google", onTap: signInWithGoogle)),
                        const SizedBox(width: 12),
                        Expanded(child: _socialBtn(iconPath: "", label: "Apple", isApple: true, onTap: signInWithApple)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Don't have an account?", style: TextStyle(color: Colors.white60, fontSize: 13)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text("Sign Up", style: TextStyle(color: Color(0xFF8BE9FF), fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassField({required IconData icon, required String hint, required TextEditingController controller, bool isPass = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white.withOpacity(0.2))),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF8BE9FF), size: 18),
              const SizedBox(width: 10),
              Expanded(child: TextField(controller: controller, obscureText: isPass ? _obscure : false, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Color(0xFFA8D8FF)), border: InputBorder.none))),
              if (isPass) GestureDetector(onTap: () => setState(() => _obscure = !_obscure), child: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.white54, size: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialBtn({required String iconPath, required String label, bool isApple = false, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 48,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.10), borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white.withOpacity(0.2))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(iconPath, style: TextStyle(color: Colors.white, fontSize: isApple ? 22 : 18, fontWeight: FontWeight.bold)),
              const SizedBox(width: 6),
              Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _waveTop() => CustomPaint(size: const Size(double.infinity, 80), painter: _WaveTopPainter());
  Widget _waveBottom() => CustomPaint(size: const Size(double.infinity, 120), painter: _WaveBottomPainter());
}

class _WaveTopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white.withOpacity(0.08)..style = PaintingStyle.fill;
    final path = Path()..moveTo(0, 40)..quadraticBezierTo(size.width * 0.3, 0, size.width * 0.6, 30)..quadraticBezierTo(size.width * 0.9, 60, size.width, 20)..lineTo(size.width, 0)..lineTo(0, 0)..close();
    canvas.drawPath(path, p);
  }
  @override bool shouldRepaint(_) => false;
}
class _WaveBottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white.withOpacity(0.06)..style = PaintingStyle.fill;
    final path = Path()..moveTo(0, 60)..quadraticBezierTo(size.width * 0.4, 100, size.width, 40)..lineTo(size.width, 120)..lineTo(0, 120)..close();
    canvas.drawPath(path, p);
  }
  @override bool shouldRepaint(_) => false;
}