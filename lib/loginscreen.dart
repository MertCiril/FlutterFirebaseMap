import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaldeneme/register.dart';
import 'package:finaldeneme/splashscreen1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}


bool registerState=false;
bool _isPasswordEightCharacters = false;
bool _hasPasswordOneNumber = false;
bool _hasCharacter = false;
var email,passwordNew;
var _key=GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  int activeIndex = 0;
  var email, passwordNew;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        activeIndex++;

        if (activeIndex == 5)
          activeIndex = 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  height: 350,
                  child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 0 ? 1 : 0,
                            duration: Duration(seconds: 1,),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://www.kafkas.edu.tr/dosyalar/bil-muh/image/23006304680.jpg',
                              height: 200,),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 1 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://www.gedik.edu.tr/wp-content/uploads/halit-oz-400x300.jpg',
                              height: 200,),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 2 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://i1.rgstatic.net/ii/profile.image/278444601561113-1443397774993_Q512/Halit-Oz.jpg',
                              height: 200,),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 3 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://app2brain.com/wp-content/uploads/2015/04/img_lesson_word_phrase_do_you_speak_english-1.jpg',
                              height: 200,),
                          ),
                        ), Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 4 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://static.vecteezy.com/system/resources/previews/002/413/518/original/now-or-never-neon-signs-style-text-vector.jpg',
                              height: 200,),
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 40,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (receivedEmail) {
                    email = receivedEmail;
                  },

                  decoration: InputDecoration(

                    contentPadding: EdgeInsets.all(0.0),
                    labelText: 'Email',
                    hintText: 'E-mail',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    prefixIcon: Icon(
                      Iconsax.user, color: Colors.black, size: 18,),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.shade200, width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  onChanged: (receivedPassword) {
                    passwordNew = receivedPassword;
                  },
                  obscureText: true,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    labelText: 'Password',
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Icon(
                      Iconsax.key, color: Colors.black, size: 18,),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.shade200, width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                MaterialButton(
                  onPressed: () {

                    Connection(email, passwordNew);

                    // Navigator.push(context, MaterialPageRoute(builder: (_)=>SplashScreen1()));

                  },
                  height: 45,
                  color: Colors.deepPurpleAccent,
                  child: Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?', style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (_) => RegisterScreen()));
                      },
                      child: Text('Register', style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }



  Connection(String email, String passwordNew) async {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: passwordNew).then((user)   {

      //eger basarılıysa anasayfaya git

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>SplashScreen1()   ), (route) => false);


    }).catchError((hata){


      Fluttertoast.showToast(msg: "Please check your information");


    });
  }
}
