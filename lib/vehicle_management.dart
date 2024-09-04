import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class VehicleManagement extends StatefulWidget {
  const VehicleManagement({super.key});

  @override
  State<VehicleManagement> createState() => _VehicleManagementState();
}

class _VehicleManagementState extends State<VehicleManagement> {
  TextEditingController tyreController = TextEditingController();
  TextEditingController oilController = TextEditingController();
  TextEditingController brakepadController = TextEditingController();
  TextEditingController filterController = TextEditingController();
  TextEditingController coolentController = TextEditingController();
  TextEditingController fluidController = TextEditingController();
  TextEditingController batteryController = TextEditingController();
  TextEditingController routineController = TextEditingController();
  TextEditingController washController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Management"),
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildContainer('Tyre Maintenance', 'assets/images/tyre.png',
                        tyreController),
                    buildContainer(
                        'Engine Oil', 'assets/images/oil.png', oilController),
                    buildContainer('Brake-Pad Maintenance',
                        'assets/images/brakepad.png', brakepadController),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildContainer('AC Filters', 'assets/images/filter.png',
                        filterController),
                    buildContainer('Coolent', 'assets/images/coolent.png',
                        coolentController),
                    buildContainer('Fluids Maintenance',
                        'assets/images/fluids.png', fluidController),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildContainer('Battery Checkup',
                        'assets/images/battery.png', batteryController),
                    buildContainer('Routine Checkup',
                        'assets/images/checkup.png', routineController),
                    buildContainer(
                        'Car wash', 'assets/images/wash.png', washController),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Container(
                      width: 500,
                      child: ElevatedButton(
                        onPressed: () async {
                          final userId = FirebaseAuth.instance.currentUser?.uid;
                          if (userId != null) {
                            CollectionReference collRef = FirebaseFirestore
                                .instance
                                .collection('maintenance')
                                .doc(userId)
                                .collection('records');
                            await collRef.add({
                              'tyre_maintenance': tyreController.text,
                              'oil_maintenance': oilController.text,
                              'brakepad_maintenance': brakepadController.text,
                              'filters_maintenance': filterController.text,
                              'coolent_maintenance': coolentController.text,
                              'fluid_maintenance': fluidController.text,
                              'battery_maintenance': batteryController.text,
                              'routine_maintenance': routineController.text,
                              'wash_maintenance': washController.text,
                            });

                            // Clear the text fields
                            tyreController.clear();
                            oilController.clear();
                            brakepadController.clear();
                            filterController.clear();
                            coolentController.clear();
                            fluidController.clear();
                            batteryController.clear();
                            routineController.clear();
                            washController.clear();

                            // Set a timer for notification
                            // Set to 10 seconds for testing purposes
                            Timer(Duration(seconds: 5), () {
                              showNotification(context, 'Change your tyres');
                            });
                          }
                        },
                        child: Text("Done"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 5),
      ),
    );
  }

  Widget buildContainer(
      String text, String imagePath, TextEditingController dataController) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Image.asset(imagePath),
          ),
          Container(
            height: 30,
            width: 300,
            color: Colors.white,
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: "Enter Last maintenance date",
              ),
              controller: dataController,
            ),
          ),
        ],
      ),
    );
  }
}
