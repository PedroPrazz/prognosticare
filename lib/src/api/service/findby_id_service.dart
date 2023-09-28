import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/pessoa_model.dart';

final storage = FlutterSecureStorage();

class GetFindbyIDService {
  static Future<Pessoa> getFindbyID() async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');


    final url = Uri.parse(UriTest.url.toString()+'/register-person/find/$idPessoa');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        Pessoa pessoa = Pessoa.fromJson(jsonData);
          
        return pessoa;
      } else {
        print('Response Status Code: ${response.statusCode}');
        throw Exception('Exeption no método find');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Exeption no método find Erro no Try/Catch');
    }
  }
}
