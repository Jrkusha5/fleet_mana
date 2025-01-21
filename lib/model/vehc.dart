class Vehicle {
  final String id;
  final String name;
  final String location;
  int fuelLevel;
  int batteryLevel;

  Vehicle({
    required this.id,
    required this.name,
    required this.location,
    required this.fuelLevel,
    required this.batteryLevel,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'],
      name: json['name'],
      location: json['location'] ?? 'Unknown',
      fuelLevel: json['fuelLevel'] ?? 0,
      batteryLevel: json['batteryLevel'] ?? 0,
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

  copyWith({required int fuelLevel, required int batteryLevel}) {}
}
