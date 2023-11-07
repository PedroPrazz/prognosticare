import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/dependent_model.dart';

final storage = FlutterSecureStorage();

class DependentService {

  //Método get para lista de dependents

  static Future<List<Dependente>> getDependentList() async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    final url = Uri.parse(UriServidor.url.toString() +
        '/register-person/list-dependents/$idPessoa');

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

  //Método para desabilitar dependente

  static Future<bool> disableDependente(String dependentId) async {
    String? token = await storage.read(key: 'token');
    final url = Uri.parse(
        UriServidor.url.toString() + '/register-person/disable/$dependentId');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        // Exclusão bem-sucedida, o servidor retornou um código 204 (No Content).
        return true;
      } else if (response.statusCode == 404) {
        // Dependente não encontrado, você pode lidar com isso de acordo com suas necessidades.
        return false;
      } else {
        print('Response Status Code: ${response.statusCode}');
        throw Exception('Exeption no método deleteDependent');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Exeption no método deleteDependent Erro no Try/Catch');
    }
  }

  //Método para criar dependente

  static Future<bool> getRegisterD(Dependente dependente) async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    final url =
        Uri.parse(UriServidor.url.toString() + '/register-person/add-dependent/$idPessoa');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'nome': dependente.nome,
          'cpf': dependente.cpf,
          'dataNascimento': dependente.dataNascimento,
          'tipoSanguineo': dependente.tipoSanguineo,
          'alergia': dependente.alergia,
          'tipoAlergia': dependente.tipoAlergia,
          'cartaoNacional': dependente.cartaoNacional,
          'cartaoPlanoSaude': dependente.cartaoPlanoSaude,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
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
  
  //Método para atualizar dependente

  static Future<bool> updateDependent(Dependente dependente) async {
    String? token = await storage.read(key: 'token');
    final url = Uri.parse(
        UriServidor.url.toString() + '/register-person/update-dependent');

    try {
      final response = await http.put(
        url,
        body: json.encode({
          'pessoaId': dependente.pessoaId,
          'nome': dependente.nome,
          'cpf': dependente.cpf,
          'dataNascimento': dependente.dataNascimento,
          'tipoSanguineo': dependente.tipoSanguineo,
          'alergia': dependente.alergia,
          'tipoAlergia': dependente.tipoAlergia,
          'cartaoNacional': dependente.cartaoNacional,
          'cartaoPlanoSaude': dependente.cartaoPlanoSaude,
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

        throw Exception('Erro ao atualizar Dependente');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Erro de Try Catch ao atualizar Dependente');
    }
  }

}
