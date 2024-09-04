import 'package:auto_aura/build_dreamgarage.dart';
import 'package:auto_aura/car_categories.dart';
import 'package:auto_aura/entertainment.dart';
import 'package:auto_aura/find_car.dart';
import 'package:auto_aura/fuel&chargingstation.dart';
import 'package:auto_aura/marketplace.dart';
import 'package:auto_aura/more.dart';
import 'package:auto_aura/navigation&maps.dart';
import 'package:auto_aura/plan_road_trip.dart';
import 'package:auto_aura/profile.dart';
import 'package:auto_aura/search.dart';
import 'package:auto_aura/vehicle_management.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, dynamic>?> fetchMapFromFirestore(
      String collection, String docId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>?;
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/profile_image.png'),
                ),
                SizedBox(width: 10),
                Text(
                  'My Profile',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Main Buttons Section
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircleButton('assets/images/car.png', 'Blogs', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CarCategories()),
                        );
                      }),
                      _buildCircleButton('assets/images/garage.webp',
                          'Build Your Dream Garage', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Build_Dreamgarage()),
                        );
                      }),
                      _buildCircleButton('assets/images/find.png', 'Find a Car',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Find_car()),
                        );
                      }),
                      _buildCircleButton(
                          'assets/images/map.png', 'Navigation & Maps', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Navigation_Maps()),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircleButton('assets/images/fuel_pump.png',
                          'Fuel & Charging Station Finder', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Fuel_charging_station()),
                        );
                      }),
                      _buildCircleButton(
                          'assets/images/wrench.png', 'Vehicle Management', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VehicleManagement()),
                        );
                      }),
                      _buildCircleButton(
                          'assets/images/road.png', 'Plan a Road Trip', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlanRoadTrip()),
                        );
                      }),
                      _buildCircleButton(
                          'assets/images/music.png', 'In-Car Entertainment',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Entertainment()),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            // News & Events Section
            Text(
              'News & Events',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 10),
            FutureBuilder<Map<String, dynamic>?>(
              future:
                  fetchMapFromFirestore('news&events', 'yfY4fbdrGn2MyEAUVm1m'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.white));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No data found',
                      style: TextStyle(color: Colors.white));
                } else {
                  var newsData = snapshot.data!['news'];
                  var eventData = snapshot.data!['events'];
                  return Row(
                    children: [
                      SizedBox(width: 200),
                      _buildNewsOrEventContainer(
                          newsData['title'] ?? 'No Title',
                          newsData['content'] ?? 'No Content',
                          'assets/images/news.jpg'),
                      SizedBox(width: 300),
                      _buildNewsOrEventContainer(
                          eventData['title'] ?? 'No Title',
                          eventData['content'] ?? 'No Content',
                          'assets/images/event.jpg'),
                    ],
                  );
                }
              },
            ),
          ],
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

  Widget _buildCircleButton(
      String imagePath, String title, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNewsOrEventContainer(
      String title, String content, String imagePath) {
    return Container(
      height: 100,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        title,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  width: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        content,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
