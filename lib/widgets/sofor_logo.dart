import 'package:flutter/material.dart';

class SoforLogo extends StatelessWidget {
  final double size;
  const SoforLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.3,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // --- NICHER STEERING WHEEL ---
          Positioned(
            bottom: 0,
            child: Container(
              width: size * 0.85,
              height: size * 0.85,
              decoration: BoxDecoration(
                color: const Color(0xFF0B4D2A), // Green
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: size * 0.06),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Steering er 3 ta spoke
                  Transform.rotate(angle: 0, child: Container(width: size*0.12, height: size*0.7, color: const Color(0xFF0B4D2A))),
                  Transform.rotate(angle: 2.09, child: Container(width: size*0.12, height: size*0.7, color: const Color(0xFF0B4D2A))),
                  Transform.rotate(angle: -2.09, child: Container(width: size*0.12, height: size*0.7, color: const Color(0xFF0B4D2A))),
                  
                  // Middle white circle
                  Container(
                    width: size*0.32, height: size*0.32,
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  ),
                  // S letter
                  Text('S', style: TextStyle(color: const Color(0xFFA05A3C), fontWeight: FontWeight.bold, fontSize: size*0.28, fontStyle: FontStyle.italic)),
                  
                  // Green inner border
                  Container(
                    width: size*0.85, height: size*0.85,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2), color: Colors.transparent),
                  )
                ],
              ),
            ),
          ),
          
          // --- UPORE BROWN LOCATION PIN ---
          Positioned(
            top: 0,
            child: Container(
              width: size * 0.62,
              height: size * 0.78,
              decoration: const BoxDecoration(
                color: Color(0xFFA05A3C), // Brown
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Transform.rotate(
                angle: -0.78,
                child: Container(
                  margin: EdgeInsets.all(size*0.08),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Transform.rotate(
                    angle: 0.78,
                    child: Center(
                      child: Text('سفر', style: TextStyle(color: Color(0xFF0B4D2A), fontWeight: FontWeight.bold, fontSize: size*0.18)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}