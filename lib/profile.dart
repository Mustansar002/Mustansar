import 'package:auto_aura/main.dart';
import 'package:auto_aura/show_garage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class My_account extends StatefulWidget {
  const My_account({super.key});

  @override
  State<My_account> createState() => _My_accountState();
}

class _My_accountState extends State<My_account> {
  final auth = FirebaseAuth.instance;

  Future<void> _showLogoutDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                await auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(title: ''),
                  ),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Account'),
          backgroundColor: Color.fromARGB(255, 151, 0, 0),
          actions: [
            IconButton(
              onPressed: () {
                _showLogoutDialog();
              },
              icon: Icon(Icons.logout_outlined),
            ),
            SizedBox(
              width: 50,
            )
          ],
        ),
        body: Center(
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowGarage(),
                    ));
              },
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  "Show Garage",
                  style: TextStyle(fontSize: 15),
                )),
              )),
        ));
  }
}
