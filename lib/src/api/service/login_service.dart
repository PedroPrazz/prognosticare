// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/api/service/findby_id_service.dart';
import 'package:prognosticare/src/config/uri.dart';
import '../../models/pessoa_model.dart';

final storage = FlutterSecureStorage();

class LoginService {
  static Future<bool> getLogin(String email, String password) async {


    final url = Uri.parse(UriServer.url.toString()+'/login');

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
        await storage.write(key: 'nome', value: dados['nome']);



        String? idPessoa = await storage.read(key: 'user_id');
        String? nome = await storage.read(key: 'nome');
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