import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';  // Import Google Fonts
import 'package:vehc_app/model/vehc.dart';
import 'package:vehc_app/provider/vehc.dart';
import 'package:vehc_app/screen/addVehc.dart';
import 'package:vehc_app/screen/update.dart';

class VehicleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vehicle List',
          style: GoogleFonts.poppins(),  // Apply Poppins font to the AppBar title
        ),
      ),
      body: FutureBuilder(
        future:
            Provider.of<VehicleProvider>(context, listen: false).fetchVehicles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${snapshot.error}',
                    style: GoogleFonts.poppins(fontSize: 16),  // Error text with Poppins font
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<VehicleProvider>(context, listen: false)
                          .fetchVehicles();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return Consumer<VehicleProvider>(
              builder: (context, vehicleProvider, child) {
                final vehicles = vehicleProvider.vehicles;

                if (vehicles.isEmpty) {
                  return const Center(child: Text('No vehicles found.'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    return VehicleCard(vehicle: vehicles[index]);
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
}

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleCard({Key? key, required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.black,
                ),
                const SizedBox(height: 12),
                Text(
                  vehicle.name,
                  style: GoogleFonts.poppins(  // Apply Poppins font to vehicle name
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  'Location: ${vehicle.location}',
                  style: GoogleFonts.poppins(fontSize: 14),  // Apply Poppins font to location text
                  overflow: TextOverflow.ellipsis,
                ),
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
          Positioned(
            bottom: 10,
            left: 10,
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdateVehicleScreen(vehicle: vehicle),
                  ),
                );
              },
            ),
          ),
        ],
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
              style: GoogleFonts.poppins(  // Apply Poppins font to percentage text
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
          style: GoogleFonts.poppins(fontSize: 12),  // Apply Poppins font to label text
        ),
      ],
    );
  }
}
