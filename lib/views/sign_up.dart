import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_app/services/auth.dart';
import 'package:test_app/views/news_page.dart';
import 'package:test_app/views/sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passConfController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  AuthService _authService = AuthService();
  String regString = "Registering, please wait..";
  bool isRegistering = false;

  Map<String, String> map = {
    "email": "",
    "username": "",
    "password": "",
    "passwordConf": ""
  };

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                child: Image.asset(
                  'images/bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                  child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 5,
                  sigmaX: 5,
                ),
                child: Container(color: Colors.transparent),
              )),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150.0, left: 50.0),
                child: Text(
                  "Welcome!!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: screenHeight / 1.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Form(
                        key: _globalKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 28.0),
                              child: TextFormField(
                                validator: (v) {
                                  if(v.isEmpty) {
                                    return "Please enter an email";
                                  } else if (!v.contains("@") || !v.contains(".com")) {
                                    return "Bad email format";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20.0),
                                  hintText: "Email:",
                                  hintStyle: TextStyle(color: Colors.white),
                                  fillColor: Colors.brown[300],
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 28.0),
                              child: TextFormField(
                                validator: (v) {
                                  if(v.isEmpty) {
                                    return "Please enter a password";
                                  } else if (passwordController.text.length < 5) {
                                    return "Password should not be less than 5 characters";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                controller: passwordController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20.0),
                                  hintText: "Password:",
                                  hintStyle: TextStyle(color: Colors.white),
                                  fillColor: Colors.brown[300],
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 28.0),
                              child: TextFormField(
                                validator: (v) {
                                  if(v.isEmpty) {
                                    return "Please re-enter password";
                                  } else if (passConfController.text != passwordController.text) {
                                    return "Passwords do not match, please try again";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                controller: passConfController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20.0),
                                  hintText: "Re-enter Password:",
                                  hintStyle: TextStyle(color: Colors.white),
                                  fillColor: Colors.brown[300],
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        height: 40.0,
                        width: 120.0,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            onPressed: () async {

                              setState(() {
                                isRegistering = true;
                              });

                              map = {
                                "email": "${emailController.text.trim()}",
                                "username": "${emailController.text.split("@")[0]}",
                                "password": "${passwordController.text.trim()}",
                                "passwordConf": "${passConfController.text.trim()}"
                              };

                              if(_globalKey.currentState.validate()){
                                await _authService.signUp(map).then((value){
                                  if(value == "Email is already used."){
                                      setState(() {
                                        regString = "Email is already used.";
                                      });
                                  } else if (value == "You are regestered,You can login now.") {
                                    setState(() {
                                      regString = "You are regestered,You can login now.";
                                    });
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> NewsPage()));

                                  } else {
                                    setState(() {
                                      regString = "Error register the details, please try after sometime";
                                    });
                                  }
                                });
                              }
                            },
                            child: Text("Sign Up")),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      isRegistering ? Text(regString) : SizedBox.shrink(),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth / 5,
                            height: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Or Sign Up With',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: screenWidth / 5,
                            height: 2,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/g.png',
                            scale: 8,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Image.asset('images/fb.png',
                              scale: 10, fit: BoxFit.contain),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Have an account?'),
                          SizedBox(
                            width: 2.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (c) => SignInPage()));
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
