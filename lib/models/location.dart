class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  // Factory method to create Location from map
  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
    );
  }

  // Convert Location to a map
  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
