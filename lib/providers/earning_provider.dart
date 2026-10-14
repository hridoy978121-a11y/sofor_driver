import 'package:flutter/material.dart';

class EarningProvider with ChangeNotifier {
  double totalEarnings = 450.0;
  double todayEarnings = 120.0;
  int totalTrips = 3;

  void addEarning(double amount) {
    totalEarnings += amount;
    todayEarnings += amount;
    totalTrips += 1;
    notifyListeners();
  }
}