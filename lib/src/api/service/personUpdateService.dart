import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/models/pessoa.dart';

class PersonUpdateService {
  static Future<bool> getPerson(Pessoa pessoa) async {

    final apiLocal = ('http://localhost:8080//register-person/update'); // variavel para local host
    final apiServer = ('http://prognosticare.ddns.net:8085/register-person/update'); // variavel para server
    
    final url = Uri.parse(apiServer);

    try {
      final response = await http.put(
        url,
        body: json.encode({
          'pessoa_id': pessoa.pessoaId,
          'nome': pessoa.nome,
          'cpf': pessoa.cpf,
          'contato': pessoa.contato,
          'dataNascimento': pessoa.dataNascimento,
          'tipoSanguineo': pessoa.tipoSanguineo,
          'alergia': pessoa.alergia,
          'tipoAlergia': pessoa.tipoAlergia,
          'tipoResponsavel': pessoa.tipoResponsavel,
          'cartaoNacional': pessoa.cartaoNacional,
          'cartaoPlanoSaude': pessoa.cartaoPlanoSaude,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
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