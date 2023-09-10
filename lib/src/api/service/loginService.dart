import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/api/service/getFindbyIDService.dart';
import '../../models/pessoa.dart';

final storage = FlutterSecureStorage();

class LoginService {
  static Future<bool> getLogin(String email, String password) async {
    final url = Uri.parse('http://prognosticare.ddns.net:8085/login');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final dados = json.decode(responseBody);

        await storage.write(key: 'token', value: dados['token']);
        await storage.write(key: 'user_id', value: dados['pessoaEntity']);

        String? idPessoa = await storage.read(key: 'user_id');

        Pessoa pessoa = await GetFindbyIDService.getFindbyID();

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
