import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class Button extends StatefulWidget {
  const Button({Key? key}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          width: 300,
          height: 300,
          color: Colors.black,
          child: AnimatedButton(
            width: 200,
            text: 'SUBMIT',
            selectedTextColor: Colors.black,
            transitionType: TransitionType.BOTTOM_TO_TOP,
            textStyle: TextStyle(
                fontSize: 28,
                letterSpacing: 5,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w300),
            onPress: () {},
          ),
        ),
      ),
    );
  }
}
