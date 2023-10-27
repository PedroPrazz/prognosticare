import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';

final storage = FlutterSecureStorage();

class AccompanyService {
  
  //Método para criar um acompanhamento
  static Future<bool> getAccompany(Accompany accompany) async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    final url =
        Uri.parse(UriServidor.url.toString() + '/to-accompany/save/$idPessoa');

    try {
      final response = await http.post(
        url,
        body: json.encode({
            'tipoAcompanhamento': accompany.tipoAcompanhamento,
            'medicacao': accompany.medicacao,
            'dataAcompanhamento': accompany.dataAcompanhamento,
            'notificacao': accompany.notificacao,
            'intervaloHora': accompany.intervaloHora,
            'tipoTemporarioControlado': accompany.tipoTemporarioControlado,
            'prescricaoMedica': accompany.prescricaoMedica
          
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

  //Método get para listar acompanhamentos
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
      } else if (response.statusCode == 404) {
        print(
            'Status Code: ${response.statusCode} Não foi encontrado Acompanhamento');
        throw Exception('Exeption no método find erro 404');
      } else {
        print('Status Code: ${response.statusCode}');
        throw Exception('Exeption no método find');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Exeption no método find Erro no Try/Catch');
    }
  }

  //Método para atualizar acompanhamentos
  static Future<bool> updateAccompany(Accompany accompany) async {
    String? token = await storage.read(key: 'token');

    final url = Uri.parse(UriServidor.url.toString() + '/to-accompany/update');

    try {
      final response = await http.put(
        url,
        body: json.encode({
          'id': accompany.id,
          'dataAcompanhamento': accompany.dataAcompanhamento,
          'tipoAcompanhamento': accompany.tipoAcompanhamento,
          'statusEvento': accompany.statusEvento,
          'intervaloHora': accompany.intervaloHora,
          'notificacao': accompany.notificacao,
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


  //Método para atualizar status acompanhamentos
  static Future<bool> updateStatus(Accompany accompany) async {
    String? token = await storage.read(key: 'token');

    final url = Uri.parse(UriServidor.url.toString() +
        '/to-accompany/update-status/' +
        (accompany.id ?? ''));

    try {
      final response = await http.put(
        url,
        body: json.encode({
          'statusEvento': accompany.statusEvento,
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

  //Método get para listar acompanhamentos do dia
  static Future<List<Accompany>> getAccompanyListByFiltro() async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    final url =
        Uri.parse(UriServidor.url.toString() + '/to-accompany/list-day/$idPessoa');
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
        throw Exception('Exeption no método getAccompanyListByFiltro');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Exeption no método find Erro no Try/Catch');
    }
  }

}
