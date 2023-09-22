import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/dependent_model.dart';

final storage = FlutterSecureStorage();

class DependentListService {
  static Future<List<Dependente>> getDependentList() async {
    String? idPessoa = await storage.read(key: 'user_id');

    final url = Uri.parse(
        UriServer.url.toString() + '/register-person/list-dependents/$idPessoa');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonDataList = json.decode(response.body);

        // Mapeie a lista de objetos JSON para uma lista de Dependente
        List<Dependente> dependentes = jsonDataList.map((jsonData) {
          return Dependente.fromJson(jsonData);
        }).toList();

        return dependentes;
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
