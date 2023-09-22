import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';

class ForgotPasswordService {
  static Future<bool> getNewPassword(String email) async {

      
    final url = Uri.parse(UriServer.url.toString()+'/register-person/public/forgot-password');

    try {
      final response = await http.post(
        url,
        body: json.encode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Response Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
