import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stisla_app/models/auth.dart';

class Authentication {
  static const String baseURL = "10.0.2.2:8000";

  static Future<Response> login(String email, String password) async {
    var url = Uri.http(baseURL, '/api/auth/login');

    var result = await post(url, headers: {
      "Accept": "application/json",
    }, body: {
      "email": email,
      "password": password,
      "device_name": "phone",
    });

    var jsonObject = json.decode(result.body);

    if (jsonObject['token'] != null) {
      var user = Auth.makelogin(jsonObject, email, password, "phone");
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('email', user.email);
      localStorage.setString('password', user.password);
      localStorage.setString('deviceName', user.deviceName);
      localStorage.setString('token', user.token);
      print(jsonObject['token']);
      // return 'authenticated';
    } else {
      // return 'anauthenticated';
      print(jsonObject['message']);
    }
    return result;
  }

  static Future<String> logout(String token) async {
    var url = Uri.http(baseURL, '/api/auth/logout');

    var result = await post(url, headers: {
      'Authorization': 'Bearer $token',
      "Accept": "application/json",
    });

    if (result.body.isEmpty) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('email');
      localStorage.remove('password');
      localStorage.remove('deviceName');
      localStorage.remove('token');
      print("token = ${localStorage.getString('token')}");
      return 'Success';
    } else {
      var jsonObject = json.decode(result.body);
      return jsonObject['message'];
    }
  }
}
