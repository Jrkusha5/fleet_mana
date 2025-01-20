import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehc_app/model/vehc.dart';
import 'package:vehc_app/provider/vehc.dart';

class UpdateVehicleScreen extends StatefulWidget {
  final Vehicle vehicle;

  UpdateVehicleScreen({required this.vehicle});

  @override
  _UpdateVehicleScreenState createState() => _UpdateVehicleScreenState();
}

class _UpdateVehicleScreenState extends State<UpdateVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  late int _fuelLevel;
  late int _batteryLevel;

  @override
  void initState() {
    super.initState();
    // Initialize the fuel and battery levels from the current vehicle
    _fuelLevel = widget.vehicle.fuelLevel;
    _batteryLevel = widget.vehicle.batteryLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Vehicle Levels'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update Fuel and Battery Levels',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                       
                      ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _fuelLevel.toString(),
                  decoration: InputDecoration(
                    labelText: 'Fuel Level',
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 2, 5, 10)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey.shade50,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a fuel level';
                    }
                    try {
                      int.parse(value);
                    } catch (_) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      _fuelLevel = int.parse(value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _batteryLevel.toString(),
                  decoration: InputDecoration(
                    labelText: 'Battery Level',
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 2, 4, 8)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey.shade50,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a battery level';
                    }
                    try {
                      int.parse(value);
                    } catch (_) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      _batteryLevel = int.parse(value);
                    }
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 3, 7, 5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      // Update the vehicle with the new levels
                      final updatedVehicle = widget.vehicle.copyWith(
                        fuelLevel: _fuelLevel,
                        batteryLevel: _batteryLevel,
                      );
                      context.read<VehicleProvider>().updateVehicle(updatedVehicle);
                      Navigator.pop(context); // Go back to the previous screen
                    }
                  },
                  child: Text(
                    'Update Vehicle',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
