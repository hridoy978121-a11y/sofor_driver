import 'package:flutter/material.dart';

class AdvanceDetailsScreen extends StatelessWidget {
  final String type;
  final String date;
  final String from;
  final String to;
  final String fare;

  const AdvanceDetailsScreen({
    super.key,
    this.type = "INTERCITY",
    this.date = "Tomorrow, 15 Oct - 8:00 AM",
    this.from = "Dhaka, Mirpur 10",
    this.to = "Cumilla, Kandirpar",
    this.fare = "BDT 2500",
  });

  @override
  Widget build(BuildContext context) {
    bool isRent = type.contains("RENT");

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("$type Details", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                // Passenger Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const CircleAvatar(radius: 24, backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11")),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rahim Ahmed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(Icons.star, size: 14, color: Colors.orange),
                                SizedBox(width: 4),
                                Text("4.8 • 120 trips", style: TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                        child: const Icon(Icons.call, color: Colors.green, size: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Trip Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isRent ? Colors.blue.shade50 : Colors.red.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(type, style: TextStyle(color: isRent ? Colors.blue : const Color(0xFFE52D27), fontWeight: FontWeight.bold, fontSize: 11)),
                          ),
                          Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildRouteRow(icon: Icons.circle, color: Colors.green, text: from, isFirst: true),
                      const Padding(padding: EdgeInsets.only(left: 5), child: Text("│", style: TextStyle(color: Colors.grey, height: 1.2))),
                      _buildRouteRow(icon: Icons.location_on, color: Colors.red, text: to, isBold: true),
                      const Divider(height: 24),
                      _infoRow("Distance", isRent ? "Included" : "98 km"),
                      _infoRow("Duration", isRent ? type : "2h 30m"),
                      _infoRow("Payment", "Cash"),
                      _infoRow("Fare", fare, isLarge: true),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
                        child: const Row(
                          children: [
                            Icon(Icons.info_outline, size: 16, color: Colors.grey),
                            SizedBox(width: 8),
                            Expanded(child: Text("ভাই একটু সকাল সকাল আসবেন, ১টা ব্যাগ থাকবে।", style: TextStyle(fontSize: 13))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRent ? Colors.blue.shade700 : const Color(0xFFE52D27),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("$type Booking Accepted!"), backgroundColor: Colors.green),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Confirm Accept", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteRow({required IconData icon, required Color color, required String text, bool isFirst = false, bool isBold = false}) {
    return Row(
      children: [
        Icon(icon, size: isFirst ? 12 : 16, color: color),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: 14))),
      ],
    );
  }

  Widget _infoRow(String title, String value, {bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isLarge ? 18 : 14, color: isLarge ? const Color(0xFFE52D27) : Colors.black)),
        ],
      ),
    );
  }
}