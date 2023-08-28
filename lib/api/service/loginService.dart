import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();
class LoginService {
  static Future<bool> getLogin(String email, String password) async {

  final userId = await storage.read(key: 'user_id');
    final url = Uri.parse('http://localhost:8080/login');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = response.body;
        final dados = json.decode(responseBody);

        print(dados);

        await storage.write(key: 'token', value: dados['token']);
        await storage.write(key: 'user_id', value: dados['userId']);
        print('User ID: $userId');
        return true;

      } else {
        print('Response Status Code: ${response.statusCode}');
        print({response.body});
        print('Erro no login!');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
