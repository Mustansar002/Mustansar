import 'package:auto_aura/homepage.dart';
import 'package:auto_aura/marketplace.dart';
import 'package:auto_aura/more.dart';
import 'package:auto_aura/profile.dart';
import 'package:auto_aura/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class CarsSelection extends StatefulWidget {
  final String category;

  const CarsSelection({Key? key, required this.category}) : super(key: key);

  @override
  State<CarsSelection> createState() => _CarsSelectionState();
}

class _CarsSelectionState extends State<CarsSelection> {
  late Future<Map<String, dynamic>> carData;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    carData = fetchCarData();
  }

  Future<Map<String, dynamic>> fetchCarData() async {
    String jsonString = await rootBundle.loadString('assets/car_data.json');
    final Map<String, dynamic> data = json.decode(jsonString);

    return {
      'details': data[widget.category]['details'],
      'make': data[widget.category]['make'],
      'model': data[widget.category]['model'],
      'price': data[widget.category]['price'],
      'images': data[widget.category]['images'],
      'names': data[widget.category]['names'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars Detail'),
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: carData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final details = snapshot.data!['details'];
              final images = snapshot.data!['images'];
              final texts = snapshot.data!['names'];
              final make = snapshot.data!['make'];
              final model = snapshot.data!['model'];
              final price = snapshot.data!['price'];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: ListWheelScrollView(
                        itemExtent: 180,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        children: [
                          buildCarItem(images[0]['path'], texts[0]['name']),
                          buildCarItem(images[1]['path'], texts[1]['name']),
                          buildCarItem(images[2]['path'], texts[2]['name']),
                          buildCarItem(images[3]['path'], texts[3]['name']),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: 600,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        make[selectedIndex]['name'],
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 160),
                                  Text(
                                    model[selectedIndex]['name'],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                price[selectedIndex]['range'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                color: Colors.grey,
                                child: Container(
                                  height: 80,
                                  width: 300,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          details[selectedIndex]['description'],
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Pros:',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Cons:',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Search()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Marketplace()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Extra()),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => My_account()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'MarketPlace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'My Account',
          ),
        ],
      ),
    );
  }

  Widget buildCarItem(String imagePath, String carName) {
    return Column(
      children: [
        Container(
          height: 150,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Image.asset(imagePath),
        ),
        Container(
          height: 30,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              carName,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    );
  }
}
