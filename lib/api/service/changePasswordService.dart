import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


final storage = FlutterSecureStorage();


class ChangePasswordService {
  static Future<bool> getChangePassword(String password) async {

    final userId = await storage.read(key: 'user_id');

    final url = Uri.parse('http://localhost:8080/register-person/public/change-password/$userId');

    try {
      final response = await http.put(
        url,
        body: json.encode({
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final dados = json.decode(responseBody);

        print(dados);

        await storage.write(key: 'token', value: dados['token']);
        await storage.write(key: 'user_id', value: userId);
        return true;

      } else {
        print('Response Status Code: ${response.statusCode}');
        print('User ID: $userId');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
