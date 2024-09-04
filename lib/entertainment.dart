import 'package:flutter/material.dart';

class Entertainment extends StatefulWidget {
  const Entertainment({super.key});

  @override
  State<Entertainment> createState() => _EntertainmentState();
}

class _EntertainmentState extends State<Entertainment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('In-Car Entertainment'),
          backgroundColor: Color.fromARGB(255, 151, 0, 0),
        ),
        body: Container());
  }
}
