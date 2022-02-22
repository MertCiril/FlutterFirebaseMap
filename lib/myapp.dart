import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaldeneme/loginscreen.dart';
import 'package:finaldeneme/maps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

import 'mymap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var currentUserUidHolder,currentUserEmailHolder;

class _MyAppState extends State<MyApp> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    takeCurrentUserUid();
    takeCurrentEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Location Tracker'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                  onPressed: () {
                    _getLocation();
                  },
                  child: Text('Add My Location to Firebase',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(10)

              ),
              child: TextButton(
                  onPressed: () {
                    _listenLocation();
                  },
                  child: Text('Enable Live Location',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(10)

              ),
              child: TextButton(
                  onPressed: () {
                    _stopListening();
                  },
                  child: Text('Stop Live Location',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
            ),
          ),
          Expanded(
              child: StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection("Location").doc(currentUserUidHolder).collection("My Location").snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {

                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(


                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                          Text(snapshot.data!.docs[index]["email"].toString()),
                          subtitle: Row(
                            children: [
                              Text("Enlem : "+snapshot.data!.docs[index]["Enlem Bilgisi"]
                                  .toString()),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Boylam : "+snapshot.data!.docs[index]["Boylam Bilgisi"]
                                  .toString()),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.directions),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MyMap(snapshot.data!.docs[index].id)));
                            },
                          ),
                        );
                      });
                },
              )),
        ],
      ),
    );
  }

  _getLocation() async {
    var timeHolder=DateTime.now();
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('Location').doc(currentUserUidHolder).collection("My Location").doc(timeHolder.toString()).set({
        'Enlem Bilgisi': _locationResult.latitude,
        'Boylam Bilgisi': _locationResult.longitude,
        'email': currentUserEmailHolder,
      }, SetOptions(merge: true));

      //Navigator.push(context, MaterialPageRoute(builder: (_)=>MapApp()));

      print("Location added successfully,we are going to your location");
      Fluttertoast.showToast(msg: "Location added successfully,we are going to your location");

    } catch (e) {

    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection("Location").doc(currentUserUidHolder).set({
        "Enlem Bilgisi": currentlocation.latitude,
        "Boylam Bilgisi": currentlocation.longitude,
        "email": currentUserEmailHolder,
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void takeCurrentUserUid() async {
    FirebaseAuth Auth = FirebaseAuth.instance;
    User? currentFirebaseUser = Auth.currentUser;

    setState(() {
      currentUserUidHolder = currentFirebaseUser!.uid;
    });
  }




  void takeCurrentEmail() async {
    FirebaseAuth Auth = FirebaseAuth.instance;
    User? currentFirebaseUser = Auth.currentUser;

    setState(() {
      currentUserEmailHolder = currentFirebaseUser!.email;
    });
  }


  }

