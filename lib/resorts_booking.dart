import 'package:flutter/material.dart';

class Resorts_booking extends StatefulWidget {
  const Resorts_booking({super.key});

  @override
  State<Resorts_booking> createState() => _Resorts_bookingState();
}

class _Resorts_bookingState extends State<Resorts_booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
        title: Text("Book a Resort"),
      ),
      body: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          uibuilder('assets/images/resort1.png', 'Single Room Resort', 8000,'This Resort is composed of single room, one master bed and attach bath.'),
          uibuilder('assets/images/resort2.png', 'Double Room Resort', 12000,'This Resort is composed of two rooms, two master bed and two seperate baths.'),
          uibuilder('assets/images/resort3.png', 'Full Resort', 20000,'This Resort is composed of three rooms, three master bed, a kitchnet and three seperate baths.'),
        ],
      ))
    );
  }
}

Widget uibuilder(
  String imagepath,
  String text,
  int price,
    String details,
) {
  bool detailshow=false;
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      height: 600,
      width: 200,
      child: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
            child: Image.asset(imagepath),
          ),
          Container(
            height: 50,
            width: 200,
            color: Colors.white,
            child: Center(child: Text(text,style: TextStyle(fontSize: 16),)),
          ),
          Container(
            height: 50,
            width: 200,
            color: Colors.white,
            child: Center(child: Text("RS $price",style: TextStyle(fontSize: 16),)),
          ),
          Container(
            width: 200,
            height: 50,
            color: Colors.white,
            child: Center(child: RentButton()),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
            child: Column(
              children: <Widget>[
                ExpansionTile(
                  title: Text("Details"),
                  trailing: Icon(detailshow ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down),
                  children: <Widget>[
                    ListTile(
                      title: Text(details),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
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
      child: Text("Book this Resort"),
    );
  }
}
