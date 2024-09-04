import 'package:flutter/material.dart';

class RentACar extends StatefulWidget {
  const RentACar({super.key});

  @override
  State<RentACar> createState() => _RentACarState();
}

class _RentACarState extends State<RentACar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Rent a Car'),
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                uibuilder('assets/images/alto.png', 'Suzuki Alto', '1000'),
                uibuilder('assets/images/wagonr.png', 'Suzuki WagonR', '1000'),
                uibuilder('assets/images/corolla.png', 'Toyota Corolla', '2500')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                uibuilder('assets/images/bolan.png', 'Suzuki Bolan', '2000'),
                uibuilder(
                    'assets/images/karvaan.png', 'Changan Karvaan', '2000'),
                uibuilder('assets/images/hiace.png', 'Toyota Hiace', '5000')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                uibuilder('assets/images/bj-40.png', 'Baic BJ 40', '7000'),
                uibuilder('assets/images/revo.png', 'Toyota Revo', '8000'),
                uibuilder(
                    'assets/images/fortuner.png', 'Toyota Fortuner', '10000')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RentButton extends StatefulWidget {
  @override
  _RentButtonState createState() => _RentButtonState();
}

class _RentButtonState extends State<RentButton> {
  bool _isRented = false;

  @override
  Widget build(BuildContext context) {
    return _isRented
        ? Center(
            child: Text(
              "Not Available",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          )
        : ElevatedButton(
            onPressed: () {
              setState(() {
                _isRented = true;
              });
            },
            child: Text("Rent this Car"),
          );
  }
}

Widget uibuilder(String imagepath, String text, String price) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      width: 300,
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 300,
            child: Image.asset(imagepath),
          ),
          Container(
            height: 30,
            width: 300,
            color: Colors.white,
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          Container(
            height: 20,
            width: 300,
            color: Colors.white,
            child: Center(
              child: Text(
                "RS $price",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          Container(
            width: 300,
            height: 30,
            child: Center(child: RentButton()),
          ),
        ],
      ),
    ),
  );
}
