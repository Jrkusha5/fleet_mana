import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vehc_app/model/vehc.dart';

class VehicleProvider extends ChangeNotifier {
  final String baseUrl = 'https://veh-back.onrender.com/api/vehicles';

  List<Vehicle> _vehicles = [];

  List<Vehicle> get vehicles => _vehicles;

  /// Fetch all vehicles from the backend
  Future<void> fetchVehicles() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _vehicles = data.map((e) => Vehicle.fromJson(e)).toList();
        notifyListeners();
      } else {
        debugPrint('Failed to load vehicles. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching vehicles: $e');
    }
  }

  /// Add a new vehicle to the backend
  Future<void> addVehicle(Vehicle vehicle) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: json.encode(vehicle.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        _vehicles.add(Vehicle.fromJson(json.decode(response.body)));
        notifyListeners();
      } else {
        debugPrint('Failed to add vehicle. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error adding vehicle: $e');
    }
  }

  /// Update an existing vehicle in the backend
  Future<void> updateVehicle(Vehicle vehicle) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${vehicle.id}'),
        body: json.encode(vehicle.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final updatedVehicle = Vehicle.fromJson(json.decode(response.body));
        int index = _vehicles.indexWhere((v) => v.id == updatedVehicle.id);
        if (index != -1) {
          _vehicles[index] = updatedVehicle;
          notifyListeners();
        }
      } else {
        debugPrint('Failed to update vehicle. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error updating vehicle: $e');
    }
  }
}
