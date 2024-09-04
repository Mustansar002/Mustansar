import 'package:flutter/material.dart';

class Extra extends StatefulWidget {
  const Extra({super.key});

  @override
  State<Extra> createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Extra'),
          backgroundColor: Color.fromARGB(255, 151, 0, 0),
        ),
        body: Container());
  }
}
