class TripModel {
  final String id;
  final String pickup;
  final String drop;
  final double distanceKm;
  final int fare;
  final String district;
  TripModel({required this.id, required this.pickup, required this.drop, required this.distanceKm, required this.fare, required this.district});
}