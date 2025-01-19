import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehc_app/provider/vehc.dart';
import 'package:vehc_app/screen/home.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => VehicleProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
