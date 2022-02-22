import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaldeneme/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Home Page"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((user) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                      (route) => false);
                });
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Container(
        color: Colors.deepPurpleAccent,
        child: ElevatedButton(

          onPressed: () {},
          child: Text("Current Location"),

        ),
      ),
    );
  }
}
