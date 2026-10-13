import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationService {
  StreamSubscription<Position>? _positionStream;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<bool> checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }

  void startTracking() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10),
    ).listen((Position pos) {
      String? uid = _auth.currentUser?.uid;
      if (uid != null) {
        _firestore.collection('drivers').doc(uid).update({
          'lat': pos.latitude,
          'lng': pos.longitude,
          'lastUpdate': FieldValue.serverTimestamp(),
          'isOnline': true,
        });
      }
    });
  }

  void stopTracking() {
    _positionStream?.cancel();
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      _firestore.collection('drivers').doc(uid).update({'isOnline': false});
    }
  }
}