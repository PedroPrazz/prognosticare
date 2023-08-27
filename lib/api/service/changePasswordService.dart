import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangePasswordService {
  static Future<bool> getChangePassword(String password) async {
    final url = Uri.parse('http://localhost:8080/register-person/public/change-password/{id}');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = response.body;
        final dados = json.decode(responseBody);

        print(dados);

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
