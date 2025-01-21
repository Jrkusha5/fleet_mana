import 'package:flutter/material.dart';
import 'package:vehc_app/model/vehc.dart';
import 'package:vehc_app/provider/vehc.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

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
    _fuelLevel = widget.vehicle.fuelLevel as int;
    _batteryLevel = widget.vehicle.batteryLevel as int;
  }

  void _updateVehicle() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
        await vehicleProvider.updateVehicle(
          Vehicle(
            id: widget.vehicle.id,
            fuelLevel: _fuelLevel,
            batteryLevel: _batteryLevel,
            name: widget.vehicle.name,
            location: widget.vehicle.location,
          ),
        );
        Navigator.pop(context); // Go back to the previous screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vehicle updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update vehicle')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Vehicle',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Vehicle Name
                TextFormField(
                  initialValue: widget.vehicle.name,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Name',
                    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  enabled: false,
                ),
                SizedBox(height: 16),
                
                // Location
                TextFormField(
                  initialValue: widget.vehicle.location,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  enabled: false,
                ),
                SizedBox(height: 16),
                
                // Fuel Level
                TextFormField(
                  initialValue: _fuelLevel.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Fuel Level (0-100)',
                    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (value) {
                    _fuelLevel = int.tryParse(value) ?? _fuelLevel;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) < 0 || int.parse(value) > 100) {
                      return 'Please enter a valid fuel level between 0 and 100';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                
                // Battery Level
                TextFormField(
                  initialValue: _batteryLevel.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Battery Level (0-100)',
                    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (value) {
                    _batteryLevel = int.tryParse(value) ?? _batteryLevel;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) < 0 || int.parse(value) > 100) {
                      return 'Please enter a valid battery level between 0 and 100';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                
                // Update Button
                ElevatedButton(
                  onPressed: _updateVehicle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 5, 8, 14),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Update Vehicle',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white),
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
