import 'package:finaldeneme/splashscreen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        width: double.infinity,
        height: double.infinity,
         decoration: BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topRight,
             end: Alignment.bottomLeft,
             colors: [
               Color(0xffCF8FF7),
               Color(0xff9413e0)
             ]
           )
         ),
        child: Column(

          children: [


            Padding(
              padding: const EdgeInsets.fromLTRB(40, 200, 10, 10),
              child: Row(children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
              child: Row(
                children: [
                  Text(
                    "You can add TO DO list with this app or..",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
              child: AnimatedButton(
                backgroundColor: Colors.black,
                borderRadius: 20,
                width: 200,
                text: 'Continue',
                selectedTextColor: Colors.black,
                transitionType: TransitionType.BOTTOM_TO_TOP,
                textStyle: TextStyle(
                    fontSize: 28,
                    letterSpacing: 3,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                onPress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SplashScreen2()));
                },
              ),
            ),],
        ),

      ),

    );
  }
}
