import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Build_Dreamgarage extends StatefulWidget {
  const Build_Dreamgarage({super.key});

  @override
  State<Build_Dreamgarage> createState() => _Build_DreamgarageState();
}

class _Build_DreamgarageState extends State<Build_Dreamgarage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Build Your Dream Garage'),
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildCarRow([
                  buildwidget('assets/images/alto.png', 'Suzuki Alto'),
                  buildwidget('assets/images/wagonr.png', 'Suzuki Wagon R'),
                  buildwidget('assets/images/picanto.png', 'Kia Picanto'),
                  buildwidget('assets/images/swift.png', 'Suzuki Swift'),
                ]),
                buildCarRow([
                  buildwidget('assets/images/city.png', 'Honda City'),
                  buildwidget('assets/images/yaris.png', 'Toyota Yaris'),
                  buildwidget('assets/images/alsvin.png', 'Changan Alsvin'),
                  buildwidget('assets/images/saga.png', 'Proton Saga'),
                ]),
                buildCarRow([
                  buildwidget('assets/images/civic.png', 'Honda Civic X'),
                  buildwidget('assets/images/grande.png', 'Toyota Grande'),
                  buildwidget('assets/images/elantra.png', 'Hyundai Elantra'),
                  buildwidget('assets/images/sonata.png', 'Hyundai Sonata'),
                ]),
                buildCarRow([
                  buildwidget('assets/images/sportage.png', 'Kia Sportage'),
                  buildwidget('assets/images/tucson.png', 'Hyundai Tucson'),
                  buildwidget('assets/images/mg-hs.png', 'MG HS'),
                  buildwidget('assets/images/oshan.png', 'Changan Oshan'),
                ]),
                buildCarRow([
                  buildwidget('assets/images/fortuner.png', 'Toyota Fortuner'),
                  buildwidget('assets/images/h6.png', 'Haval H6'),
                  buildwidget(
                      'assets/images/cross.png', 'Toyota Corolla Cross'),
                  buildwidget('assets/images/glory.png', 'DFSK Glory 580'),
                ]),
                buildCarRow([
                  buildwidget('assets/images/revo.png', 'Toyota Revo'),
                  buildwidget('assets/images/dmax.png', 'Isuzu D-Max'),
                  buildwidget('assets/images/vigo.png', 'Toyota Vigo'),
                  buildwidget('assets/images/hilux.png', 'Toyota Hilux'),
                ]),
                buildCarRow([
                  buildwidget('assets/images/lc-300.png', 'Toyota LC 300'),
                  buildwidget('assets/images/bj-40.png', 'Toyota Grande'),
                  buildwidget('assets/images/prado.png', 'Hyundai Elantra'),
                  buildwidget('assets/images/jimmny.png', 'Suzuki Jimmny'),
                ]),
                buildCarRow([
                  buildwidget('assets/images/etron-gt.png', 'Audi e-tron GT'),
                  buildwidget(
                      'assets/images/e-tron.png', 'Audi e-tron 50 Quattro'),
                  buildwidget('assets/images/ix.png', 'BMW iX'),
                  buildwidget('assets/images/model-3.png', 'Tesla Model 3'),
                ]),
                buildCarRow([
                  buildwidget('assets/images/hiace.png', 'Toyota Hiace'),
                  buildwidget('assets/images/carnival.png', 'Kia Carnival'),
                  buildwidget('assets/images/bolan.png', 'Suzuki Bolan'),
                  buildwidget('assets/images/karvaan.png', 'Changan Karvaan'),
                ]),
                buildCarRow([
                  buildwidget('assets/images/c63.png', 'W204 Mercedes AMG C63'),
                  buildwidget('assets/images/m3.png', 'E92 BMW M3'),
                  buildwidget('assets/images/rx8.png', 'Mazda RX 8'),
                  buildwidget('assets/images/350z.png', 'Nissan 350 Z'),
                ]),
                buildCarRow([
                  buildwidget(
                      'assets/images/old_city.png', 'Honda City 5th Gen'),
                  buildwidget('assets/images/corolla.png', 'Toyota Corolla'),
                  buildwidget('assets/images/reborn.png', 'Honda Civic Reborn'),
                  buildwidget(
                      'assets/images/old_alto.png', 'Suzuki Alto 5th gen'),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCarRow(List<Widget> cars) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: cars
          .map(
            (car) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: car,
            ),
          )
          .toList(),
    );
  }

  Widget buildwidget(String imagepath, String carname) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            width: 300,
            height: 100,
            child: Image.asset(imagepath),
          ),
          Container(
            width: 300,
            height: 50,
            child: Center(
              child: Text(
                "$carname",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () async {
                  final userid = FirebaseAuth.instance.currentUser?.uid;
                  if (userid != null) {
                    final garageDoc = FirebaseFirestore.instance
                        .collection('my_garage')
                        .doc(userid);
                    final carData = {
                      'carname': carname,
                      'imagepath': imagepath,
                      'timestamp':
                          DateTime.now().millisecondsSinceEpoch.toString()
                    };
                    await garageDoc
                        .collection('cars')
                        .doc(carData['timestamp'])
                        .set(carData);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$carname added to garage succesfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text(
                  "ADD to Garage",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
