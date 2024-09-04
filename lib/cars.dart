import 'package:flutter/material.dart';

class Cars extends StatefulWidget {
  const Cars({super.key});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cars Categories'),
          backgroundColor: Color.fromARGB(255, 151, 0, 0),
        ),
        body: Container());
  }
}
