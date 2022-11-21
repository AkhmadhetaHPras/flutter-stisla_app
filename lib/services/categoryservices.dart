import 'package:http/http.dart';

class CategoryServices {
  static const String baseURL = "10.0.2.2:8000";

  static Future<Response> getAll(String token) async {
    var url = Uri.http(baseURL, '/api/categories');

    var result = await get(
      url,
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    return result;
  }
}
