import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/pessoa_model.dart';

final storage = FlutterSecureStorage();
class PersonUpdateService {
  static Future<Pessoa> getPerson(Pessoa pessoa) async {

  String? token = await storage.read(key: 'token');
    final url = Uri.parse(UriServidor.url.toString()+'/register-person/update');

    try {
      final response = await http.put(
        url,
        body: json.encode({
          'pessoaId': pessoa.pessoaId,
          'nome': pessoa.nome,
          'cpf': pessoa.cpf,
          'email': pessoa.email,
          'contato': pessoa.contato,
          'dataNascimento': pessoa.dataNascimento,
          'tipoSanguineo': pessoa.tipoSanguineo,
          'alergia': pessoa.alergia,
          'tipoAlergia': pessoa.tipoAlergia,
          'tipoResponsavel': pessoa.tipoResponsavel,
          'doador': pessoa.doador,
          'cartaoNacional': pessoa.cartaoNacional,
          'cartaoPlanoSaude': pessoa.cartaoPlanoSaude,
        }),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
        
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        Pessoa pessoa = Pessoa.fromJson(jsonData);
        
        return pessoa;
      } else {
        print('Response Status Code: ${response.statusCode}');
        
        throw Exception('Erro ao atualizar Pessoa');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Erro de Try Catch ao atualizar pessoa');
    }
  }
}
