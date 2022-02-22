
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
bool registerState=false;
bool _isVisible = false;
bool _isPasswordEightCharacters = false;
bool _hasPasswordOneNumber = false;
bool _hasCharacter = false;
var email,passwordNew;
var _key=GlobalKey<FormState>();


class _RegisterScreenState extends State<RegisterScreen> {


  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
   final characterRegex= RegExp(r'[a-z]');




    passwordNew=password;

    setState(() {
      _isPasswordEightCharacters = false;
      if(passwordNew.length >= 8) {
        _isPasswordEightCharacters = true;
      }

      _hasPasswordOneNumber = false;
      if(numericRegex.hasMatch(password)) {
        _hasPasswordOneNumber = true;
      }

      _hasCharacter=false;
      if(characterRegex.hasMatch(password)) {
        _hasCharacter=true;
      }



    });
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Scaffold(

       // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("Create Your Account", style: TextStyle(color: Colors.white),),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 20,),

                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged:(receivedEmail){
                    email=receivedEmail;
                  },
                  validator:(receivedEmail){
                 return receivedEmail!.contains("@")? null : "Invalid Email Try Again";

                  },

                  decoration: InputDecoration(
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)
                    ),
                    hintText: "E-Mail",
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                ),


                SizedBox(height: 20,),
                TextField(
                  onChanged: (password) => onPasswordChanged(password),
                  obscureText: !_isVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: _isVisible ? Icon(Icons.visibility, color: Colors.black,) :
                      Icon(Icons.visibility_off, color: Colors.grey,),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)
                    ),
                    hintText: "Password",
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: _isPasswordEightCharacters ?  Colors.green : Colors.transparent,
                          border: _isPasswordEightCharacters ? Border.all(color: Colors.transparent) :
                          Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(child: Icon(Icons.check, color: Colors.white, size: 15,),),
                    ),
                    SizedBox(width: 10,),
                    Text("Length at least 8 characters")
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: _hasPasswordOneNumber ?  Colors.green : Colors.transparent,
                          border: _hasPasswordOneNumber ? Border.all(color: Colors.transparent) :
                          Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(child: Icon(Icons.check, color: Colors.white, size: 15,),),
                    ),
                    SizedBox(width: 10,),
                    Text("Contains at least 1 number")
                  ],
                ),
                SizedBox(height: 10,),

                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: _hasCharacter ?  Colors.green : Colors.transparent,
                          border: _hasCharacter ? Border.all(color: Colors.transparent) :
                          Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(child: Icon(Icons.check, color: Colors.white, size: 15,),),
                    ),
                    SizedBox(width: 10,),
                    Text("Contains at least 1 character")
                  ],
                ),
                SizedBox(height: 50,),
                MaterialButton(
                  height: 40,
                  minWidth: double.infinity,
                  onPressed: () {
                    //buraya regsiter butonu eklenecek!!!!
                    addRegister();


                  },
                  color: Colors.deepPurpleAccent,
                  child: Text("CREATE ACCOUNT", style: TextStyle(color: Colors.white),),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}

addRegister() {

  if(_hasCharacter&&_hasPasswordOneNumber&&_isPasswordEightCharacters&&_key.currentState!.validate()){
    Fluttertoast.showToast(msg: "Registration completed successfully");


    Connection(email,passwordNew);

  }
  else{
    Fluttertoast.showToast(msg: "Registration could not be completed, please check your information");

  }
}

 Connection(String email, String passwordNew) async {

  final Author=FirebaseAuth.instance;
  UserCredential authResult;


  if(registerState){
    print("connectteki if geldi mi");
    authResult=await Author.signInWithEmailAndPassword(email: email, password: passwordNew);




  }
  else{

      authResult = await Author.createUserWithEmailAndPassword(email: email, password: passwordNew);
      String uidHolder = authResult.user!.uid;

      await FirebaseFirestore.instance.collection("Users").doc(uidHolder).set({"email":email});

  }

}

