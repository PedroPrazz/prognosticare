import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotPasswordService {
  static Future<bool> getNewPassword(String email) async {

    final apiLocal = ('http://localhost:8080/register-person/public/forgot-password'); // variavel para local host
    final apiServer = ('http://prognosticare.ddns.net:8085/register-person/public/forgot-password'); // variavel para server
    
    final url = Uri.parse(apiServer);

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
