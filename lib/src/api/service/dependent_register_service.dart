import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/dependent_model.dart';

final storage = FlutterSecureStorage();

class RegisterServiceDepents {
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
}
