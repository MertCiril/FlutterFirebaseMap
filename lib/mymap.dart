import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaldeneme/addnote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

import 'myapp.dart';

class MyMap extends StatefulWidget {
  // var currentUserUidHolder,currentUserEmailHolder;
  final String user_id;

  MyMap(this.user_id);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
           IconButton(onPressed:(){
             goPage();
           }, icon:Icon(Icons.add))
          ],
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(
            "Add Note to Curennt Location",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Location")
              .doc(currentUserUidHolder)
              .collection("My Location")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (_added) {
              mymap(snapshot);
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return GoogleMap(
              mapType: MapType.normal,
              markers: {
                Marker(
                    position: LatLng(
                      snapshot.data!.docs.singleWhere((element) =>
                          element.id == widget.user_id)["Enlem Bilgisi"],
                      snapshot.data!.docs.singleWhere((element) =>
                          element.id == widget.user_id)["Boylam Bilgisi"],
                    ),
                    markerId: MarkerId('id'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueMagenta)),
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                    snapshot.data!.docs.singleWhere((element) =>
                        element.id == widget.user_id)["Enlem Bilgisi"],
                    snapshot.data!.docs.singleWhere((element) =>
                        element.id == widget.user_id)["Boylam Bilgisi"],
                  ),
                  zoom: 14.47),
              onMapCreated: (GoogleMapController controller) async {
                setState(() {
                  _controller = controller;
                  _added = true;
                });
              },
            );
          },
        ));
  }

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)["Enlem Bilgisi"],
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)["Boylam Bilgisi"],
            ),
            zoom: 14.47)));
  }

  void takeCurrentUserUid() async {
    FirebaseAuth Auth = FirebaseAuth.instance;
    User? currentFirebaseUser = Auth.currentUser;

    setState(() {
      currentUserUidHolder = currentFirebaseUser!.uid;
    });
  }

  void goPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddNote()));
  }
}
