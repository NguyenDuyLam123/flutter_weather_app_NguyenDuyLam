// lib/models/location_model.dart
class LocationModel {
  final double latitude;
  final double longitude;
  final String? name;

  LocationModel({required this.latitude, required this.longitude, this.name});
}
