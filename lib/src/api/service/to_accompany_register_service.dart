import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';

final storage = FlutterSecureStorage();

class AccompanyService {
  static Future<bool> getAccompany(String medicacao, String dataAcompanhamento, String prescricaoMedica, String tipoTemporarioControlado, String tipoAcompanhamento) async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    final url =
        Uri.parse(UriServer.url.toString() + '/to-accompany/save/$idPessoa');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'medicacao': medicacao,
          'dataAcompanhamento': dataAcompanhamento,
          'prescricaoMedica': prescricaoMedica,
          'tipoTemporarioControlado': tipoTemporarioControlado,
          'tipoAcompanhamento': tipoAcompanhamento,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = response.body;
        final dados = json.decode(responseBody);

        await storage.write(key: 'token', value: dados['token']);
        await storage.write(key: 'user_id', value: dados['pessoaEntity']);

        return true;
      } else {
        print('Response Status Code: ${response.statusCode}');
        print({response.body});
        print('Erro ao cadastrar evento!');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
