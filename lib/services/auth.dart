import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {

  var apiRegistrationResponse = "";

  String registerApi = "https://nodejs-register-login-app.herokuapp.com";

  String loginApi = "https://nodejs-register-login-app.herokuapp.com/login";


  Future<String> signUp(map) async {

    var response = await http.post(Uri.parse(registerApi), body: map);

    if(response.statusCode == 200) {
      var responseString = jsonDecode(response.body);

      apiRegistrationResponse = responseString["Success"];

      return apiRegistrationResponse;
    } else {
      return apiRegistrationResponse;
    }

  }

  Future<String> signIn(map) async {
    var response = await http.post(Uri.parse(loginApi), body: map);

    if(response.statusCode == 200) {
      var responseString = jsonDecode(response.body);

      apiRegistrationResponse = responseString["Success"];

      print(apiRegistrationResponse);

      return apiRegistrationResponse;
    } else {
      return apiRegistrationResponse;
    }

  }

}