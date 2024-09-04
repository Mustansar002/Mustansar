import 'package:auto_aura/guide_display.dart';
import 'package:flutter/material.dart';

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
        title: Text("Select Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                uibuilder(context, "assets/images/murree.jpg", 'Murree',
                    'destination_1'),
                SizedBox(width: 50),
                uibuilder(context, "assets/images/sakardu.jpg", 'Skardu',
                    'destination_2'),
                SizedBox(width: 50),
                uibuilder(context, "assets/images/medows.jpg", 'Fairy Meadows',
                    'destination_3'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                uibuilder(context, "assets/images/swat.jpg", 'Swat Valley',
                    'destination_4'),
                SizedBox(width: 50),
                uibuilder(context, "assets/images/lahore.jpg", 'Lahore',
                    'destination_5'),
                SizedBox(width: 50),
                uibuilder(context, "assets/images/neelum.jpg", 'Neelum Valley',
                    'destination_6'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                uibuilder(context, "assets/images/hunza.jpg", 'Hunza Valley',
                    'destination_7'),
                SizedBox(width: 50),
                uibuilder(context, "assets/images/karachi.jpg", 'Karachi',
                    'destination_8'),
                SizedBox(width: 50),
                uibuilder(context, "assets/images/islamabad.jpg", 'Islamabad',
                    'destination_9'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget uibuilder(
    BuildContext context, String imagepath, String text, String jsonDataKey) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Guide_Display(category: jsonDataKey),
        ),
      );
    },
    child: Column(
      children: [
        Container(
          height: 120,
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Image.asset(imagepath, fit: BoxFit.cover),
        ),
        Container(
          height: 30,
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    ),
  );
}
