import 'package:flutter/material.dart';
import 'ride_request_card.dart';
import '../ride/ride_history_screen.dart';
import '../wallet/earning_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final List<Widget> _pages = const [
    HomeMapView(),
    RideHistoryScreen(),
    EarningScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00A86B),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: "Rides"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Earning"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class HomeMapView extends StatefulWidget {
  const HomeMapView({super.key});
  @override
  State<HomeMapView> createState() => _HomeMapViewState();
}

class _HomeMapViewState extends State<HomeMapView> {
  bool isOnline = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sofor"), backgroundColor: const Color(0xFF00A86B)),
      body: Stack(
        children: [
          Container(color: Colors.grey[300], child: const Center(child: Text("Map - Bukit Garam, Shah Alam"))),
          Positioned(top: 10, left: 10, right: 10,
            child: Card(child: SwitchListTile(title: Text(isOnline ? "Online" : "Offline"), value: isOnline, onChanged: (v)=> setState(()=> isOnline = v)))
          ),
          if(isOnline) const Positioned(bottom: 20, left: 10, right: 10, child: RideRequestCard()),
        ],
      ),
    );
  }
}