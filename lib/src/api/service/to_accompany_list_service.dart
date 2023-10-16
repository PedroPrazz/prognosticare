import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';

final storage = FlutterSecureStorage();

class ToAccompanyListService {
  static Future<List<Accompany>> getAccompanyList() async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    final url =
        Uri.parse(UriServidor.url.toString() + '/to-accompany/list/$idPessoa');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonDataList = json.decode(response.body);

        List<Accompany> accompany = jsonDataList.map((jsonData) {
          return Accompany.fromJson(jsonData);
        }).toList();

        return accompany;
      } else {
        print('Response Status Code: ${response.statusCode}');
        throw Exception('Exeption no método find');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Exeption no método find Erro no Try/Catch');
    }
  }

  static Future<bool> updateAccompany(Accompany accompany) async {
    String? token = await storage.read(key: 'token');
    final url = Uri.parse(
        UriServidor.url.toString() + '/to-accompany/update');

    try {
      final response = await http.put(
        url,
        body: json.encode({
          'id': accompany.id,
          'dataAcompanhamento': accompany.dataAcompanhamento,
          'tipoAcompanhamento': accompany.tipoAcompanhamento,
          'statusEvento': accompany.statusEvento,
          // 'intervaloHora': accompany.intervaloHora,
          'medicacao': accompany.medicacao,
          'tipoTemporarioControlado': accompany.tipoTemporarioControlado,
          'prescricaoMedica': accompany.prescricaoMedica,

        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {

        return true;
      } else {
        print('Response Status Code: ${response.statusCode}');

        throw Exception('Erro ao atualizar Acompanhamento');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Erro de Try Catch ao atualizar Acompanhamento');
    }
  }

}
