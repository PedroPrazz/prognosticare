import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prognosticare/model/pessoa.dart';

final storage = FlutterSecureStorage();

class GetFindbyIDService {
  static Future<Pessoa> getFindbyID() async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');
    final url = Uri.parse(
        'http://prognosticare.ddns.net:8085//register-person/find/$idPessoa');

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
        // print(pessoa.nome);
        return pessoa;
      } else {
        print('Response Status Code: ${response.statusCode}');
        throw Exception('DSFDSFDF');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('DSFDSFDF');
    }
  }
}
