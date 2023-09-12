import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/pessoa.dart';

final storage = FlutterSecureStorage();

class GetFindbyIDService {
  static Future<Pessoa> getFindbyID() async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    // final apiLocal = ('http://localhost:8080//register-person/find/$idPessoa'); // variavel para local host
    // final apiServer = ('http://prognosticare.ddns.net:8085/register-person/find/$idPessoa'); // variavel para server
    
    // final url = Uri.parse(apiServer);

    final url = Uri.parse(UriServer.url.toString()+'/register-person/find/$idPessoa');

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
