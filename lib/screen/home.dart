import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehc_app/provider/vehc.dart';
import 'package:vehc_app/screen/addVehc.dart';
import 'package:vehc_app/screen/update.dart';

class VehicleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle List'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<VehicleProvider>(context, listen: false).fetchVehicles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Consumer<VehicleProvider>(
              builder: (context, vehicleProvider, child) {
                final vehicles = vehicleProvider.vehicles;

                if (vehicles.isEmpty) {
                  return const Center(child: Text('No vehicles found.'));
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = vehicles[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.directions_car,
                                  size: 40,
                                  color: const Color.fromARGB(255, 3, 6, 20),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  vehicle.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Location: ${vehicle.location}'),
                              ],
                            ),
                          ),
                          if (vehicle.fuelLevel != null)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: _buildCircularIndicator(
                                label: 'Fuel',
                                value: vehicle.fuelLevel!,
                              ),
                            ),
                          if (vehicle.batteryLevel != null)
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: _buildCircularIndicator(
                                label: 'Battery',
                                value: vehicle.batteryLevel!,
                              ),
                            ),
                          // Update IconButton
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: const Color.fromARGB(255, 245, 166, 48),
                              ),
                              onPressed: () {
                                // Navigate to the UpdateVehicleScreen
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UpdateVehicleScreen(
                                      vehicle: vehicle,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddVehicleScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircularIndicator({required String label, required int value}) {
    final color = value > 50 ? Colors.green : Colors.red;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: value / 100,
                strokeWidth: 6,
                color: color,
              ),
            ),
            Text(
              '$value%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
