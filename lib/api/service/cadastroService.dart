import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CadastroService {
  static Future<bool> getCadastro(String nome, String cpf, String email,
      String data, String password) async {
    final url = Uri.parse('http://localhost:8080/register-person/save');

    try {
      final response = await http.post(
        url,
        body: json.encode({
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
