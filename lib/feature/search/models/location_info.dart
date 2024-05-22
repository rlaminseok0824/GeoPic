import 'dart:convert';

class LocationInfo {
  final String place;
  final double latitude;
  final double longitude;

  LocationInfo({
    required this.place,
    required this.latitude,
    required this.longitude,
  });

  factory LocationInfo.fromJson(String jsonString) {
    final jsonData = json.decode(jsonString);
    return LocationInfo(
      place: jsonData['place'],
      latitude: jsonData['latitude'],
      longitude: jsonData['longitude'],
    );
  }

  String toJson() {
    final jsonData = {
      'place': place,
      'latitude': latitude,
      'longitude': longitude,
    };
    return json.encode(jsonData);
  }
}
