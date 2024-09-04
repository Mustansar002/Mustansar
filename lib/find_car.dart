import 'package:flutter/material.dart';

class Find_car extends StatefulWidget {
  const Find_car({super.key});

  @override
  State<Find_car> createState() => _Find_carState();
}

class _Find_carState extends State<Find_car> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Find a Car'),
          backgroundColor: Color.fromARGB(255, 151, 0, 0),
        ),
        body: Container());
  }
}
