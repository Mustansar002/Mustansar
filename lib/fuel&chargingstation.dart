import 'package:flutter/material.dart';

class Fuel_charging_station extends StatefulWidget {
  const Fuel_charging_station({super.key});

  @override
  State<Fuel_charging_station> createState() => _Fuel_charging_stationState();
}

class _Fuel_charging_stationState extends State<Fuel_charging_station> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fuel & Charging Station Finder'),
          backgroundColor: Color.fromARGB(255, 151, 0, 0),
        ),
        body: Container());
  }
}
