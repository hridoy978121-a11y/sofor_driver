import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class FreeOfferBanner extends StatefulWidget {
  @override
  State<FreeOfferBanner> createState() => _FreeOfferBannerState();
}

class _FreeOfferBannerState extends State<FreeOfferBanner> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 3));
    _confettiController.play(); // App Open হলেই Confetti উড়বে
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00C853), Color(0xFF00E676)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 15, offset: Offset(0, 8))
            ],
          ),
          child: Row(
            children: [
              // LEFT SIDE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                      child: Text("FREE 🔥", style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 1)),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "তুমি চালাও,\nটাকা 100% তোমার!",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.2),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "কোন কমিশন নাই। Sofor এ বস তুমি।",
                      style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13),
                    ),
                  ],
                ),
              ),
              // RIGHT SIDE - ICON
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                child: Icon(Icons.motorcycle_rounded, color: Colors.white, size: 40),
              )
            ],
          ),
        ),
        // CONFETTI ANIMATION
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: [Colors.white, Colors.yellow, Colors.greenAccent],
          ),
        ),
      ],
    );
  }
}