import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';

final storage = FlutterSecureStorage();

class RegisterServiceDepents {
  static Future<bool> getRegisterD(
      String nome,
      String cpf,
      String data,
      String tipoSanguineo,
      bool alergia,
      String tipoAlergia,
      String cartaoNacional,
      String cartaoPlanoSaude) async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    final url =
        Uri.parse(UriServer.url.toString() + '/add-dependent/$idPessoa');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'pessoa_id': idPessoa,
          'nome': nome,
          'cpf': cpf,
          'dataNascimento': data,
          'tipoSanguineo': tipoSanguineo,
          'alergia': alergia,
          'tipoAlergia': tipoAlergia,
          'cartaoNacional': cartaoNacional,
          'cartaoPlanoSaude': cartaoPlanoSaude,
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
