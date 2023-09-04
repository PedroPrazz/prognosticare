import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RegisterServiceDepents {
  static Future<bool> getRegister(String pessoaId, String nome, String cpf,
      String email, String data, String password) async {
    final url =
        Uri.parse('http://prognosticare.ddns.net:8085//add-dependent/{id}');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'pessoa_id': pessoaId,
          'nome': nome,
          'cpf': cpf,
          'email': email,
          'dataNascimento': data,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = response.body;
        final dados = json.decode(responseBody);

        print(dados);

        final dob = DateFormat('dd/MM/yyyy').parse(data);
        final currentDate = DateTime.now();
        final age = currentDate.year -
            dob.year -
            (currentDate.month >= dob.month && currentDate.day >= dob.day
                ? 0
                : 1);

        if (age < 18) {
          print('User is not of legal age');
          return false;
        }
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
