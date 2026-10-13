import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import '../data/districts.dart';
import '../data/models/trip_model.dart';
import '../services/voice_service.dart';

class DriverProvider extends ChangeNotifier {
  bool isOnline = false;
  final voiceService = VoiceService();
  District selectedDistrict = bdDistricts.first;
  String languageCode = 'bn';
  TripModel? currentTrip;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  StreamSubscription<Position>? _posSubscription;
  StreamSubscription? _tripSubscription;

  DriverProvider() {
    _listenForTrips();
  }

  void setDistrict(District d) {
    selectedDistrict = d;
    _listenForTrips(); // District change korle notun district er trip sunbe
    notifyListeners();
  }

  void setLanguage(String code) { 
    languageCode = code; 
    notifyListeners(); 
  }

  Future<void> toggleOnline(bool val) async {
    isOnline = val;
    notifyListeners();
    
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    String uid = _auth.currentUser?.uid ?? 'test_driver_01';

    if (isOnline) {
      _posSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 20),
      ).listen((pos) {
        _firestore.collection('drivers').doc(uid).set({
          'lat': pos.latitude,
          'lng': pos.longitude,
          'district': selectedDistrict.nameEn,
          'isOnline': true,
          'lastUpdate': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      });
      voiceService.speak("${selectedDistrict.nameBn} তে অনলাইন হলেন");
    } else {
      _posSubscription?.cancel();
      try {
        await _firestore.collection('drivers').doc(uid).set({'isOnline': false}, SetOptions(merge: true));
      } catch(e) {}
    }
  }

  void _listenForTrips() {
    _tripSubscription?.cancel();
    _tripSubscription = _firestore.collection('trips')
      .where('status', isEqualTo: 'pending')
      .where('district', isEqualTo: selectedDistrict.nameEn)
      .snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty && isOnline) {
        var data = snapshot.docs.first.data();
        currentTrip = TripModel(
          id: snapshot.docs.first.id,
          pickup: data['pickupAddress'] ?? '${selectedDistrict.nameEn} Bazaar',
          drop: data['dropAddress'] ?? '${selectedDistrict.nameEn} Sadar',
          distanceKm: (data['distance'] ?? 22).toDouble(),
          fare: data['fare'] ?? 550,
          district: data['district'] ?? selectedDistrict.nameEn,
        );
        voiceService.speak("নতুন ট্রিপ এসেছে ${selectedDistrict.nameBn} থেকে");
        notifyListeners();
      }
    });
  }

  Future<void> acceptTrip() async {
    if (currentTrip == null) return;
    await _firestore.collection('trips').doc(currentTrip!.id).update({
      'status': 'accepted',
      'driverId': _auth.currentUser?.uid ?? 'test_driver_01',
      'acceptedAt': FieldValue.serverTimestamp(),
    });
    currentTrip = null;
    notifyListeners();
  }

  Future<void> rejectTrip() async {
    if (currentTrip == null) return;
    await _firestore.collection('trips').doc(currentTrip!.id).update({'status': 'rejected'});
    currentTrip = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _posSubscription?.cancel();
    _tripSubscription?.cancel();
    super.dispose();
  }
}