class Vehicle {
  final String id;
  final String name;
  final String location;
  final int fuelLevel;
  final int batteryLevel;
  final DateTime lastUpdated;

  Vehicle({
    required this.id,
    required this.name,
    required this.location,
    required this.fuelLevel,
    required this.batteryLevel,
    required this.lastUpdated,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'],
      name: json['name'],
      location: json['location'] ?? 'Unknown',
      fuelLevel: json['fuelLevel'] ?? 0,
      batteryLevel: json['batteryLevel'] ?? 0,
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'fuelLevel': fuelLevel,
      'batteryLevel': batteryLevel,
    };
  }
}
