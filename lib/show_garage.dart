import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShowGarage extends StatefulWidget {
  const ShowGarage({super.key});

  @override
  State<ShowGarage> createState() => _ShowGarageState();
}

class _ShowGarageState extends State<ShowGarage> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  late Future<List<Map<String, dynamic>>> carData;
  Map<String, List<Map<String, dynamic>>> categorizedCars = {
    'Daily runner': [],
    'SUV': [],
    'Weekend Car': [],
  };

  @override
  void initState() {
    super.initState();
    carData = fetchCars();
  }

  Future<List<Map<String, dynamic>>> fetchCars() async {
    if (userId == null) return [];
    final snapshot = await FirebaseFirestore.instance
        .collection('my_garage')
        .doc(userId)
        .collection('cars')
        .get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  void onCarDropped(String category, Map<String, dynamic> car) {
    setState(() {
      categorizedCars[category]!.add(car);
      carData = Future.value(carData.then((cars) {
        cars.remove(car);
        return cars;
      }));
    });
  }

  Future<void> removeCarFromFirebase(Map<String, dynamic> car) async {
    if (userId == null) return;
    await FirebaseFirestore.instance
        .collection('my_garage')
        .doc(userId)
        .collection('cars')
        .doc(car['id'])
        .delete();
  }

  void onCarRemoved(Map<String, dynamic> car) {
    removeCarFromFirebase(car);
    setState(() {
      carData = Future.value(carData.then((cars) {
        cars.remove(car);
        return cars;
      }));
      categorizedCars.forEach((category, carList) {
        carList.removeWhere((c) => c['id'] == car['id']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
        title: Text("My Garage"),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCategoryButton('Daily runner'),
                      buildCategoryButton('SUV'),
                      buildCategoryButton('Weekend Car'),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      SizedBox(
                        width: 405,
                      ),
                      buildRemoveWidget(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: carData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No cars in your garage.'));
                  } else {
                    final cars = snapshot.data!;
                    return ListView.builder(
                      itemCount: cars.length,
                      itemBuilder: (context, index) {
                        final car = cars[index];
                        return Draggable<Map<String, dynamic>>(
                          data: car,
                          feedback: Material(
                            child: buildCarWidget(car),
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.5,
                            child: buildCarWidget(car),
                          ),
                          child: buildCarWidget(car),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryButton(String category) {
    return DragTarget<Map<String, dynamic>>(
      onAccept: (car) {
        onCarDropped(category, car);
      },
      builder: (context, candidateData, rejectedData) {
        return Column(
          children: [
            Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                color: candidateData.isNotEmpty ? Colors.grey : Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Center(
                child: Icon(Icons.add),
              ),
            ),
            Container(
              height: 50,
              width: 200,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: candidateData.isNotEmpty ? Colors.grey : Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child:
                  Center(child: Text(category, style: TextStyle(fontSize: 16))),
            ),
            ...categorizedCars[category]!.map(buildCarWidget).toList(),
          ],
        );
      },
    );
  }

  Widget buildRemoveWidget() {
    return DragTarget<Map<String, dynamic>>(
      onAccept: (car) {
        onCarRemoved(car);
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          child: Column(
            children: [
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Icon(Icons.delete),
              ),
              Container(
                height: 50,
                width: 200,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Center(
                    child: Text("Remove", style: TextStyle(fontSize: 16))),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCarWidget(Map<String, dynamic> car) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Image.asset(
            car['imagepath'],
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 50,
          width: 200,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Center(
              child: Text(car['carname'], style: TextStyle(fontSize: 16))),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
