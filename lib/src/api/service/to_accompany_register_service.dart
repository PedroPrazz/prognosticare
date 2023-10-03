import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';

final storage = FlutterSecureStorage();

class AccompanyService {
  static Future<bool> getAccompany(Accompany accompany) async {

    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    final url = Uri.parse(UriServidor.url.toString() + '/to-accompany/save/$idPessoa');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'medicacao': accompany.medicacao,
          'dataAcompanhamento': accompany.dataAcompanhamento,
          'prescricaoMedica': accompany.prescricaoMedica,
          'tipoTemporarioControlado': accompany.tipoTemporarioControlado,
          'tipoAcompanhamento': accompany.tipoAcompanhamento,
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
