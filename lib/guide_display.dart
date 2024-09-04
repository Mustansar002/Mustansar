import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Guide_Display extends StatefulWidget {
  final String category;
  const Guide_Display({Key? key, required this.category}) : super(key: key);

  @override
  State<Guide_Display> createState() => _Guide_DisplayState();
}

class _Guide_DisplayState extends State<Guide_Display> {
  late Future<Map<String, dynamic>> currentData;

  @override
  void initState() {
    super.initState();
    currentData = fetchData();
  }

  Future<Map<String, dynamic>> fetchData() async {
    String jsonString = await rootBundle.loadString('assets/car_data.json');
    final Map<String, dynamic> data = json.decode(jsonString);

    final firstDestination = data[widget.category][0];

    return {
      'name': firstDestination['name'],
      'location': firstDestination['location'],
      'highlights': firstDestination['highlights'].join(", "),
      'activities': firstDestination['activities'].join(", "),
      'best_time_to_visit': firstDestination['best_time_to_visit'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
        title: Text("Guide"),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: currentData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: uibuilder('assets/images/globe.png', 'Name',
                            data['name'], 200),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: uibuilder('assets/images/location.png',
                            'Location', data['location'], 200),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: uibuilder(
                            'assets/images/time.png',
                            'Best time to travel',
                            data['best_time_to_visit'],
                            200),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: uibuilder('assets/images/imp.png', 'Highlights',
                          data['highlights'], 600),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: uibuilder('assets/images/activities.png',
                          'Activities', data['activities'], 600),
                    ),
                  ),
                ],
              );
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }

  Widget uibuilder(String imagepath, String title, String text, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: Image.asset(imagepath),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 60,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
