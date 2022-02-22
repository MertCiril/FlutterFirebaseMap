import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart' as loc;
import 'package:finaldeneme/mainscreen.dart';
import 'package:finaldeneme/myapp.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MapApp());

class MapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

var latitude,longtude;


class MapSampleState extends State<MapSample> {



  void initState() {
    super.initState();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    //_takeCurrentLocation();
   // loc.LocationData LocRes = location.getLocation() as loc.LocationData;
    //latitude=LocRes.latitude;
    //longtude=LocRes.longitude;

  }
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _currentLoc = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 14.4746,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed:() async{
            await FirebaseAuth.instance.signOut();
          }, icon:Icon(Icons.exit_to_app_sharp))
        ],
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "EXIT APP",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),

      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _currentLoc,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
       floatingActionButton: FloatingActionButton.extended(
         backgroundColor: Colors.deepPurpleAccent,
         onPressed: goMainMap,
        label: Text("Find Me!"),
         icon: Icon(Icons.search),
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }


  goMainMap(){

    Navigator.push(context,MaterialPageRoute(builder: (_)=>MyApp()));
  }

  // Future<void> _takeCurrentLocation() async {
  //   final loc.LocationData _locationResult = await location.getLocation();
  //   latitude=_locationResult.latitude;
  //   longtude=_locationResult.longitude;
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_currentLoc));
  // }
  //  takeCurrentLoc() async {
  //   final loc.LocationData _locationResult = await location.getLocation();
  //
  //   var enlem=_locationResult.latitude;
  //   latitude=enlem!.toDouble();
  //   var boylam=_locationResult.longitude;
  //   longtude=boylam!.toDouble();
  //
  //
  // }


}