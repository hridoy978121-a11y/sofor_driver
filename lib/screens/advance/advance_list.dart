import 'package:flutter/material.dart';
import 'advance_details.dart';

class AdvanceListScreen extends StatefulWidget {
  const AdvanceListScreen({super.key});

  @override
  State<AdvanceListScreen> createState() => _AdvanceListScreenState();
}

class _AdvanceListScreenState extends State<AdvanceListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text("Advance Booking", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFFE52D27),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFFE52D27),
          indicatorWeight: 3,
          tabs: const [
            Tab(text: "Intercity"),
            Tab(text: "Hourly Rent"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildIntercityList(),
          _buildRentList(),
        ],
      ),
    );
  }

  // 1. INTERCITY LIST
  Widget _buildIntercityList() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _buildIntercityCard(
          date: "Tomorrow, 15 Oct - 8:00 AM",
          from: "Dhaka, Mirpur 10",
          to: "Cumilla, Kandirpar",
          fare: "BDT 2500",
          distance: "98 km",
        ),
        const SizedBox(height: 12),
        _buildIntercityCard(
          date: "Today, 14 Oct - 5:00 PM",
          from: "Dhaka, Gulshan",
          to: "Chittagong",
          fare: "BDT 4000",
          distance: "260 km",
        ),
      ],
    );
  }

  // 2. RENT LIST - আলাদা ডিজাইন
  Widget _buildRentList() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _buildRentCard(
          duration: "3 HOURS",
          date: "Today, 14 Oct - 2:00 PM",
          location: "Dhaka, Dhanmondi",
          fare: "BDT 600",
          details: "City Ride • 30km included",
        ),
        const SizedBox(height: 12),
        _buildRentCard(
          duration: "5 HOURS",
          date: "Tomorrow, 15 Oct - 10:00 AM",
          location: "Dhaka, Uttara",
          fare: "BDT 1000",
          details: "Full Day • 60km included",
        ),
        const SizedBox(height: 12),
        _buildRentCard(
          duration: "2 HOURS",
          date: "Today, 14 Oct - 6:00 PM",
          location: "Dhaka, Banani",
          fare: "BDT 400",
          details: "Quick Ride • 20km included",
        ),
      ],
    );
  }

  Widget _buildIntercityCard({required String date, required String from, required String to, required String fare, required String distance}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(4)),
                child: const Text("INTERCITY", style: TextStyle(color: Color(0xFFE52D27), fontWeight: FontWeight.bold, fontSize: 11)),
              ),
              Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Row(children: [const Icon(Icons.circle, size: 10, color: Colors.green), const SizedBox(width: 8), Expanded(child: Text(from))]),
          const Padding(padding: EdgeInsets.only(left: 4, top: 2, bottom: 2), child: Text("|", style: TextStyle(color: Colors.grey))),
          Row(children: [const Icon(Icons.location_on, size: 14, color: Colors.red), const SizedBox(width: 8), Expanded(child: Text(to, style: TextStyle(fontWeight: FontWeight.bold)))]),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(fare, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(distance, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Ignore"))),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE52D27)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AdvanceDetailsScreen(
                      type: "INTERCITY",
                      date: date,
                      from: from,
                      to: to,
                      fare: fare,
                    )));
                  },
                  child: const Text("Accept", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRentCard({required String duration, required String date, required String location, required String fare, required String details}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade100)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
                child: Text("RENT - $duration", style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 11)),
              ),
              Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle), child: const Icon(Icons.timer, size: 18, color: Colors.blue)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(location, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(details, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(fare, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Text("Driver + Fuel included", style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Ignore"))),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade700),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AdvanceDetailsScreen(
                      type: "RENT - $duration",
                      date: date,
                      from: location,
                      to: details,
                      fare: fare,
                    )));
                  },
                  child: const Text("Accept", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}