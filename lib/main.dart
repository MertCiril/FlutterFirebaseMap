import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finaldeneme/animation_button.dart';
import 'package:finaldeneme/loginscreen.dart';
import 'package:finaldeneme/maps.dart';
import 'package:finaldeneme/register.dart';
import 'package:finaldeneme/splashscreen1.dart';
import 'package:finaldeneme/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginPage()

    );
    
  }

  



}









