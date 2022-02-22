import 'package:finaldeneme/mainscreen.dart';
import 'package:finaldeneme/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xffCF8FF7), Color(0xff9413e0)])),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 200, 10, 0),
                child: Row(children: [
                  Text(
                    "You can add photos from ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(120, 10, 10, 20),
              child: Row(
                children: [
                  Text(
                    "any location you want",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
              child: AnimatedButton(
                backgroundColor: Colors.black,
                borderRadius: 20,
                width: 300,
                text: "Let's Get Started",
                selectedTextColor: Colors.black,
                transitionType: TransitionType.BOTTOM_TO_TOP,
                textStyle: TextStyle(
                    fontSize: 28,
                    letterSpacing: 3,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                onPress: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MapApp()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
