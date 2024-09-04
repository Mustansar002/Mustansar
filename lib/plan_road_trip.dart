import 'package:auto_aura/e_commerceStore.dart';
import 'package:auto_aura/guide.dart';
import 'package:auto_aura/rent_a_car.dart';
import 'package:auto_aura/resorts_booking.dart';
import 'package:flutter/material.dart';

class PlanRoadTrip extends StatefulWidget {
  const PlanRoadTrip({super.key});

  @override
  State<PlanRoadTrip> createState() => _PlanRoadTripState();
}

class _PlanRoadTripState extends State<PlanRoadTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Plan a Road-Trip'),
        backgroundColor: const Color.fromARGB(255, 151, 0, 0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widgetmaker("assets/images/guide.png", "Guide", () => Guide()),
                const SizedBox(width: 30),
                widgetmaker("assets/images/store.png", 'E-Commerce Store',
                    () => ECommerceStore()),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widgetmaker("assets/images/resort.png", "Resorts Booking",
                    () => Resorts_booking()),
                const SizedBox(width: 30),
                widgetmaker(
                    "assets/images/rent.png", 'Rent A Car', () => RentACar()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetmaker(String imagepath, String text, Widget Function() builder) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => builder()),
        );
      },
      child: Column(
        children: [
          Container(
            height: 150,
            width: 300,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Image.asset(imagepath),
          ),
          Container(
            height: 50,
            width: 300,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
