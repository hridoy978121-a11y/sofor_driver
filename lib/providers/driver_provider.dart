import 'package:flutter/material.dart';
import '../data/districts.dart';
import '../data/models/trip_model.dart';
import '../services/voice_service.dart';
class DriverProvider extends ChangeNotifier {
  bool isOnline = true;
  final voiceService = VoiceService();
  District selectedDistrict = bdDistricts.first;
  String languageCode = 'bn';
  TripModel? currentTrip;

  DriverProvider() {
    currentTrip = TripModel(
      id: '1',
      pickup: '${selectedDistrict.nameEn} Bazaar',
      drop: '${selectedDistrict.nameEn} Sadar, 22 KM',
      distanceKm: 22,
      fare: 550,
      district: selectedDistrict.nameEn,
    );
  }

  void toggleOnline(bool val) { isOnline = val; notifyListeners(); }
  void setDistrict(District d) {
    selectedDistrict = d;
    currentTrip = TripModel(
      id: '1',
      pickup: '${d.nameEn} Bazaar',
      drop: '${d.nameEn} Sadar, 22 KM',
      distanceKm: 22,
      fare: 550,
      district: d.nameEn,
    );
    notifyListeners();
  }
  void setLanguage(String code) { languageCode = code; notifyListeners(); }
  void acceptTrip() { currentTrip = null; notifyListeners(); }
  void rejectTrip() { currentTrip = null; notifyListeners(); }
}