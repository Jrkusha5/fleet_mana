import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehc_app/provider/vehc.dart';
import 'package:vehc_app/screen/addVehc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              vehicleProvider.fetchVehicles(); // Refresh vehicle data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Vehicle list refreshed')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: vehicleProvider.vehicles.isEmpty
                ? const Center(
                    child: Text('No vehicles available.'),
                  )
                : ListView.builder(
                    itemCount: vehicleProvider.vehicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = vehicleProvider.vehicles[index];
                      return ListTile(
                        leading: const Icon(Icons.directions_car),
                        title: Text(vehicle.name),
                        
                        trailing: Text(
                          'Fuel: ${vehicle.fuelLevel}%, Battery: ${vehicle.batteryLevel}%',
                        ),
                      );
                    },
                  ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddVehicleScreen()),
                );
              },
              child: const Text('Add Vehicle'),
            ),
          ),
        ],
      ),
    );
  }
}
