import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';

final storage = FlutterSecureStorage();

class AccompanyService {
  static Future<bool> getAccompany(
    String tipoAcompanhamento,
    String medicacao,
    String dataAcompanhamento,
    String tipoTemporarioControlado,
    String prescricaoMedica,
  ) async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    final url =
        Uri.parse(UriServidor.url.toString() + '/to-accompany/save/$idPessoa');

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
