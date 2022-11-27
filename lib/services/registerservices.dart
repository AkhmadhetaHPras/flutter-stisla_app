import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stisla_app/models/auth.dart';
import 'package:stisla_app/models/user.dart';

class RegisterServices {
  static const String baseURL = "10.0.2.2:8000";

  static Future<Response> signup(String name, String email, String password,
      String confirmationPsd) async {
    var url = Uri.http(baseURL, '/api/auth/register');

    var result = await post(url, headers: {
      "Accept": "application/json",
    }, body: {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmationPsd,
      "device_name": "phone",
    });

    var jsonObject = json.decode(result.body);

    if (jsonObject['token'] != null) {
      var user =
          User.makeUser(jsonObject, name, email, password, confirmationPsd);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('email', user.email);
      localStorage.setString('password', user.password);
      localStorage.setString('deviceName', user.deviceName);
      localStorage.setString('token', user.token);
      print(jsonObject['token']);
    } else {
      print(jsonObject['message']);
    }

    return result;
  }
}
