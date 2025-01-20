import 'package:flutter/material.dart';
import 'package:vehc_app/model/vehc.dart';

class VehicleTile extends StatelessWidget {
  final Vehicle vehicle;

  VehicleTile({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: const Icon(Icons.directions_car, size: 40),
        title: Text(vehicle.name),
        subtitle: Text('Location: ${vehicle.location}\nFuel: ${vehicle.fuelLevel}%\nBattery: ${vehicle.batteryLevel}%'),
        trailing: Text(
          'Last Updated: ${vehicle.lastUpdated.toLocal().toString()}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
