import 'package:auto_aura/car_selection.dart';
import 'package:flutter/material.dart';

class CarCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars Categories'),
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCarCategoryContainer(context, 'Hatchbacks',
                    'assets/images/hatchback.png', 'hatchbacks'),
                buildCarCategoryContainer(
                    context, 'Sedans', 'assets/images/sedan.png', 'sedans'),
                buildCarCategoryContainer(
                    context, 'Saloons', 'assets/images/saloon.png', 'saloons'),
                buildCarCategoryContainer(context, 'Crossovers',
                    'assets/images/crossover.png', 'crossovers'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCarCategoryContainer(
                    context, 'SUVs', 'assets/images/suv.png', 'suvs'),
                buildCarCategoryContainer(
                    context, 'Jeeps', 'assets/images/jeep.png', 'jeeps'),
                buildCarCategoryContainer(context, 'Electric',
                    'assets/images/electric.png', 'electric'),
                buildCarCategoryContainer(
                    context, 'MPVs', 'assets/images/mpv.png', 'mpvs'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCarCategoryContainer(context, 'Pickup-Trucks',
                    'assets/images/pickup.png', 'pickup'),
                buildCarCategoryContainer(context, 'Sports-Cars',
                    'assets/images/sportscar.png', 'sportscars'),
                buildCarCategoryContainer(
                    context, 'Bikes', 'assets/images/bikes.png', ''),
                buildCarCategoryContainer(context, 'Used-Cars',
                    'assets/images/used-car.png', 'used-cars'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCarCategoryContainer(BuildContext context, String category,
      String imagePath, String jsonDataKey) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CarsSelection(category: jsonDataKey)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 300,
        height: 150,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Text(
                category,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
