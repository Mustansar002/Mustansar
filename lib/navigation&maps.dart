import 'package:flutter/material.dart';

class Navigation_Maps extends StatefulWidget {
  const Navigation_Maps({super.key});

  @override
  State<Navigation_Maps> createState() => _Navigation_MapsState();
}

class _Navigation_MapsState extends State<Navigation_Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Navigation & Maps'),
          backgroundColor: Color.fromARGB(255, 151, 0, 0),
        ),
        body: Container());
  }
}
