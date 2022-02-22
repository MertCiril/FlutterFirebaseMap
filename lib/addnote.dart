import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  //verileri kontrollerden alıcı

  TextEditingController noteHolder=TextEditingController();
  TextEditingController dateHolder=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Add Note"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
            child: TextFormField(
              controller: noteHolder,
              decoration: InputDecoration(
                  labelText: "Enter Note", border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: dateHolder,
              decoration: InputDecoration(
                  labelText: "Deadline", border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            height: 70,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // tıklayınca firebase e ekleme yapacak

                addData();

              },
              child: Text("Add Note"),
              style: ElevatedButton.styleFrom(primary: Colors.teal),
            ),
          )
        ],
      ),
    );
  }

  addData() async{

    FirebaseAuth Auth =  FirebaseAuth.instance;
    User? currentFirebaseUser = Auth.currentUser;//stackoverflowdan alındı!!!!!!!


    String uidHolder=currentFirebaseUser!.uid; //!!!!!!!!!!!!!!!!!
    var timeHolder=DateTime.now();

    await FirebaseFirestore.instance.collection("Notes").doc(uidHolder).collection("My Notes").doc(timeHolder.toString()).set({"Note Name":noteHolder.text,"Deadline":dateHolder.text,"Date":timeHolder.toString(),"All Date":timeHolder});

    Fluttertoast.showToast(msg: "Note added!!");


  }
}
