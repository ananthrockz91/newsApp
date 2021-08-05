import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test_app/services/auth.dart';
import 'package:test_app/views/news_page.dart';
import 'package:test_app/views/sign_up.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String signInString = "Signing in, please wait";
  bool isSigningIn = false;

  AuthService _authService = AuthService();

  Map<String, String> map = {
    "email": "",
    "password": "",
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
                        'Sign in',
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
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 28.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    decoration: TextDecoration.underline
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
                                isSigningIn = true;
                              });
                              map = {
                                "email": "${emailController.text.trim()}",
                                "password": "${passwordController.text.trim()}",
                              };

                              if(_globalKey.currentState.validate()){
                                await _authService.signIn(map).then((value){
                                  if (value == "This Email Is not regestered!") {
                                      setState(() {
                                        signInString = "This Email Is not registered, please register and try again.";
                                      });
                                  } else if (value == "Success!") {
                                    setState(() {
                                      signInString = "Success!";
                                    });
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> NewsPage()));
                                  } else {
                                    setState(() {
                                      signInString = "Error signing in. Please try later";
                                    });
                                  }
                                });
                              }

                            },
                            child: Text("Sign in")),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      isSigningIn ? Text(signInString) : SizedBox.shrink(),
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
                            'Or Sign in With',
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
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          SizedBox(
                            width: 2.0,
                          ),
                          TextButton(
                            onPressed: () {
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> SignUpPage()));
                            },
                            child: Text(
                              'Sign up',
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
