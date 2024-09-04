import 'package:auto_aura/chatbox.dart';
import 'package:auto_aura/homepage.dart';
import 'package:auto_aura/marketplace.dart';
import 'package:auto_aura/more.dart';
import 'package:auto_aura/profile.dart';
import 'package:auto_aura/search.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyCar extends StatefulWidget {
  const BuyCar({Key? key}) : super(key: key);

  @override
  State<BuyCar> createState() => _BuyCarState();
}

class _BuyCarState extends State<BuyCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Buy a Car'),
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ads').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var cars = snapshot.data!.docs;

          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              var car = cars[index];
              var carname = car['carname'] as String;
              String carpic = '';
              Color containerColor = Colors.white;

              if (carname == 'Alto') {
                carpic = "assets/images/alto.png";
              } else if (carname == 'wagon r') {
                carpic = 'assets/images/wagonr.png';
              } else if (carname == 'Picanto') {
                carpic = 'assets/images/picanto.png';
              } else if (carname == 'Swift') {
                carpic = 'assets/images/swift.png';
              } else if (carname == 'City') {
                carpic = 'assets/images/city.png';
              } else if (carname == 'Yaris') {
                carpic = 'assets/images/yaris.png';
              } else if (carname == 'Saga') {
                carpic = 'assets/images/saga.png';
              } else if (carname == 'Alsvin') {
                carpic = 'assets/images/alsvin.png';
              } else if (carname == 'Civic') {
                carpic = 'assets/images/civic.png';
              } else if (carname == 'Grande') {
                carpic = 'assets/images/grande.png';
              } else if (carname == 'Elantra') {
                carpic = 'assets/images/elantra.png';
              } else if (carname == 'Sonata') {
                carpic = 'assets/images/sonata.png';
              } else if (carname == 'Sportage') {
                carpic = 'assets/images/sportage.png';
              } else if (carname == 'Tucson') {
                carpic = 'assets/images/tucson.png';
              } else if (carname == 'Hs') {
                carpic = 'assets/images/mg-hs.png';
              } else if (carname == 'Oshan') {
                carpic = 'assets/images/oshan.png';
              } else if (carname == 'Fortuner') {
                carpic = 'assets/images/fortuner.png';
              } else if (carname == 'H6') {
                carpic = 'assets/images/h6.png';
              } else if (carname == 'Corolla cross') {
                carpic = 'assets/images/cross.png';
              } else if (carname == 'Glory') {
                carpic = 'assets/images/glory.png';
              } else if (carname == 'Land-cruiser') {
                carpic = 'assets/images/lc-300.png';
              } else if (carname == 'Bj 40') {
                carpic = 'assets/images/bj-40.png';
              } else if (carname == 'Jimmny') {
                carpic = 'assets/images/jimmny.png';
              } else if (carname == 'Prado') {
                carpic = 'assets/images/prado.png';
              } else if (carname == 'E-tron') {
                carpic = 'assets/images/etron-gt.png';
              } else if (carname == 'Ix') {
                carpic = 'assets/images/ix.png';
              } else if (carname == 'Model 3') {
                carpic = 'assets/images/model3.png';
              } else if (carname == '350 z') {
                carpic = 'assets/images/350-z.png';
              } else if (carname == 'Rx 8') {
                carpic = 'assets/images/rx-8.png';
              } else if (carname == 'Amg c63') {
                carpic = 'assets/images/c63.png';
              } else if (carname == 'E92 m3') {
                carpic = 'assets/images/m3.png';
              } else if (carname == 'Revo') {
                carpic = 'assets/images/revo.png';
              } else if (carname == 'Hilux') {
                carpic = 'assets/images/hilux.png';
              } else if (carname == 'Vigo') {
                carpic = 'assets/images/vigo.png';
              } else if (carname == 'D max') {
                carpic = 'assets/images/dmax.png';
              } else if (carname == 'Bolan') {
                carpic = 'assets/images/bolan.png';
              } else if (carname == 'Carnival') {
                carpic = 'assets/images/carnival.png';
              } else if (carname == 'Karvaan') {
                carpic = 'assets/images/karvaan.png';
              } else if (carname == 'Hiace') {
                carpic = 'assets/images/hiace.png';
              } else if (carname == 'R1') {
                carpic = 'assets/images/r1.png';
              } else if (carname == 'V rod') {
                carpic = 'assets/images/v-rod.png';
              } else if (carname == 'Tnt 600') {
                carpic = 'assets/images/tnt.png';
              } else if (carname == 'Gxr') {
                carpic = 'assets/images/gxr.png';
              } else if (carname == 'City 5th gen') {
                carpic = 'assets/images/old-city.png';
              } else if (carname == 'Corolla') {
                carpic = 'assets/images/corolla.png';
              } else if (carname == 'Civic Reborn') {
                carpic = 'assets/images/reborn.png';
              } else if (carname == 'Alto 5th gen') {
                carpic = 'assets/images/old-alto.png';
              }

              return Center(
                child: SizedBox(
                  width: 600,
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 200,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Image.asset(
                                carpic,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  car['carname'] as String,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text('Make: ${car['make']}'),
                                Text('Model: ${car['model']}'),
                                Text('Variant: ${car['variant']}'),
                                SizedBox(height: 16.0),
                              ],
                            ),
                            Spacer(), // This will push the buttons to the far right
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Buy Car",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    var sellerId = car['sellerid'] as String?;
                                    if (sellerId != null) {
                                      print(
                                          'Navigating to chat with sellerId: $sellerId'); // Debug print
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                            sellerid: sellerId,
                                          ),
                                        ),
                                      );
                                    } else {
                                      print('sellerId is null'); // Debug print
                                      // Handle case where sellerId is null
                                    }
                                  },
                                  child: Text(
                                    "Contact Seller",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Text('Price: \$${car['price']}'),
                        SizedBox(height: 8.0),
                        Text('Details: ${car['details']}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
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
}
