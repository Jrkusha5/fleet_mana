import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehc_app/model/vehc.dart';
import 'package:vehc_app/provider/vehc.dart';


class AddVehicleScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _fuelLevelController = TextEditingController();
  final TextEditingController _batteryLevelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter the status' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter the location' : null,
              ),
              TextFormField(
                controller: _fuelLevelController,
                decoration: const InputDecoration(labelText: 'Fuel Level'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || double.tryParse(value) == null
                    ? 'Please enter a valid fuel level'
                    : null,
              ),
              TextFormField(
                controller: _batteryLevelController,
                decoration: const InputDecoration(labelText: 'Battery Level'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || double.tryParse(value) == null
                    ? 'Please enter a valid battery level'
                    : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newVehicle = Vehicle(
                      id: '', // Backend will generate this
                      name: _nameController.text,
                      location: _locationController.text,
                      fuelLevel: double.parse(_fuelLevelController.text),
                      batteryLevel: double.parse(_batteryLevelController.text),
                      lastUpdated: DateTime.now(),
                    );

                    await vehicleProvider.addVehicle(newVehicle);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vehicle added successfully')),
                    );

                    // Clear the form
                    _nameController.clear();
                    _statusController.clear();
                    _locationController.clear();
                    _fuelLevelController.clear();
                    _batteryLevelController.clear();

                    Navigator.pop(context); // Navigate back to the home screen
                  }
                },
                child: const Text('Add Vehicle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
