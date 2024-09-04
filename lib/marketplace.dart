import 'package:auto_aura/buycar.dart';
import 'package:auto_aura/sellcar.dart';
import 'package:flutter/material.dart';

class Marketplace extends StatefulWidget {
  const Marketplace({super.key});

  @override
  State<Marketplace> createState() => _MarketplaceState();
}

class _MarketplaceState extends State<Marketplace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Market Place"),
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Sellcar(),
                      ));
                },
                child: Container(
                  height: 400,
                  width: 300,
                  child: Column(
                    children: [
                      Container(
                        height: 350,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Image.asset("assets/images/sellcar.png"),
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Center(
                          child: Text(
                            "Sell Car",
                            style: TextStyle(color: Colors.red, fontSize: 25),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BuyCar(),
                      ));
                },
                child: Container(
                  height: 400,
                  width: 300,
                  child: Column(
                    children: [
                      Container(
                        height: 350,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Image.asset("assets/images/buycar.png"),
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Center(
                          child: Text(
                            "Buy Car",
                            style: TextStyle(color: Colors.green, fontSize: 25),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
