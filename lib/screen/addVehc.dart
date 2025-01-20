import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehc_app/model/vehc.dart';
import 'package:vehc_app/provider/vehc.dart';

class AddVehicleScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _fuelLevelController = TextEditingController();
  final TextEditingController _batteryLevelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Vehicle Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                       ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.directions_car),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a name'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.location_on),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the location'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _fuelLevelController,
                      decoration: InputDecoration(
                        labelText: 'Fuel Level (%)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.local_gas_station),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null ||
                              int.tryParse(value) == null ||
                              int.parse(value) < 0 ||
                              int.parse(value) > 100
                          ? 'Please enter a valid fuel level (0-100)'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _batteryLevelController,
                      decoration: InputDecoration(
                        labelText: 'Battery Level (%)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.battery_full),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null ||
                              int.tryParse(value) == null ||
                              int.parse(value) < 0 ||
                              int.parse(value) > 100
                          ? 'Please enter a valid battery level (0-100)'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final newVehicle = Vehicle(
                              id: '', // Backend will generate this
                              name: _nameController.text,
                              location: _locationController.text,
                              fuelLevel: int.parse(_fuelLevelController.text),
                              batteryLevel:
                                  int.parse(_batteryLevelController.text),
                              lastUpdated: DateTime.now(),
                            );

                            await vehicleProvider.addVehicle(newVehicle);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vehicle added successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            // Clear the form
                            _nameController.clear();
                            _locationController.clear();
                            _fuelLevelController.clear();
                            _batteryLevelController.clear();

                            Navigator.pop(context); // Navigate back
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        child: const Text(
                          'Add Vehicle',
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
