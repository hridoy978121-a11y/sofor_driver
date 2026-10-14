import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/earning_provider.dart';

class RatingScreen extends StatefulWidget {
  final int fare;
  const RatingScreen({super.key, required this.fare});
  @override State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int rating = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Passenger ke Rating din"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text("${widget.fare} Taka - Trip Complete", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () => setState(() => rating = index + 1),
                  icon: Icon(Icons.star, size: 45, color: index < rating? Colors.orange : Colors.grey[300]),
                );
              }),
            ),
            const SizedBox(height: 10),
            Text("$rating Star", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.all(16)),
                onPressed: () {
                  // STEP 4 er main line - Earning add hobe
                  Provider.of<EarningProvider>(context, listen: false).addEarning(widget.fare.toDouble());
                  
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$rating Star diyechen! ${widget.fare} Taka add holo!")));
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("Submit & Home e Jan", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}