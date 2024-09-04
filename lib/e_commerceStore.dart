import 'package:flutter/material.dart';

class ECommerceStore extends StatefulWidget {
  const ECommerceStore({super.key});

  @override
  State<ECommerceStore> createState() => _ECommerceStoreState();
}

class _ECommerceStoreState extends State<ECommerceStore> {
  Map<String, double> quantities = {};
  Map<String, double> cart = {};

  void addtocart(String productname, double price) {
    var totalprice = price * (quantities[productname] ?? 0);
    cart[productname] = totalprice;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce Store'),
        backgroundColor: const Color.fromARGB(255, 151, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              productRow(
                [
                  product("assets/images/powerbank.png", 'Power Bank', 5000,
                      Colors.blue),
                  product("assets/images/headphones.png", 'Head Phones', 8000,
                      Colors.green),
                  product("assets/images/charger.png", 'Charger', 3000,
                      Colors.yellow),
                  product("assets/images/usb.png", 'USB', 2000, Colors.red),
                ],
              ),
              const SizedBox(height: 20),
              productRow(
                [
                  product("assets/images/pillow.png", 'Travel Pillow', 1000,
                      Colors.orange),
                  product(
                      "assets/images/books.png", 'Books', 1000, Colors.purple),
                  product("assets/images/bottle.png", 'Water Bottle', 100,
                      Colors.cyan),
                  product("assets/images/glass.png", 'Disposable Glass', 50,
                      Colors.teal),
                ],
              ),
              const SizedBox(height: 20),
              productRow(
                [
                  product("assets/images/chips.png", 'Chips', 100, Colors.pink),
                  product(
                      "assets/images/cookies.png", 'Cookies', 50, Colors.lime),
                  product("assets/images/colddrink.png", 'Colddrink', 80,
                      Colors.indigo),
                  product("assets/images/sandwich.png", 'Sandwich', 150,
                      Colors.amber),
                ],
              ),
              const SizedBox(height: 20),
              productRow(
                [
                  product("assets/images/kit.png", 'First Aid Kit', 1000,
                      Colors.brown),
                  product("assets/images/shoes.png", 'Hiking Shoes', 8000,
                      Colors.grey),
                  product("assets/images/bag.png", 'Sleeping Bag', 4000,
                      Colors.black),
                  product("assets/images/suitcase.png", 'Suit Case', 2500,
                      Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productRow(List<Widget> products) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: products
          .map((product) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: product,
              ))
          .toList(),
    );
  }

  Widget product(
      String imagepath, String productname, double price, Color widgetColor) {
    quantities.putIfAbsent(productname, () => 0.0);

    return Column(
      children: [
        Container(
          height: 100,
          width: 300,
          decoration: BoxDecoration(color: widgetColor),
          child: Image.asset(imagepath),
        ),
        Container(
          height: 30,
          width: 300,
          decoration: const BoxDecoration(color: Colors.white),
          child: Center(
            child: Text(
              productname,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          height: 20,
          width: 300,
          decoration: const BoxDecoration(color: Colors.white),
          child: Center(
            child: Text(
              "RS $price",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          height: 70,
          width: 300,
          child: Slider(
            divisions: 10,
            label: quantities[productname]?.toStringAsFixed(0),
            min: 0,
            max: 10,
            value: quantities[productname] ?? 0.0,
            onChanged: (newValue) {
              setState(() {
                quantities[productname] = newValue;
              });
            },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              addtocart(productname, price);
            },
            child: const Text("Add to Cart"))
      ],
    );
  }
}
