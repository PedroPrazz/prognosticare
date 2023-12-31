import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prognosticare/src/config/uri.dart';

final storage = FlutterSecureStorage();

class ChangePasswordService {
  static Future<bool> getChangePassword(String password) async {
    final userId = await storage.read(key: 'user_id');
    final token = await storage.read(key: 'token'); // Recupere o token

    
    final url = Uri.parse(UriServidor.url.toString()+'/register-person/public/change-password/$userId');

    try {
      final response = await http.put(
        url,
        body: json.encode({
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Adicione o token ao cabeçalho
        },
      );

      if (response.statusCode == 200) {
        await storage.write(
            key: 'token',
            value: 'novo_token'); // Atualize o token, se necessário
        await storage.write(key: 'user_id', value: 'pessoaEntity');
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
