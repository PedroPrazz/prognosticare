import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prognosticare/api/model/pessoa.dart';

final storage = FlutterSecureStorage();
class GetFindbyIDService {
  static Future<bool> getFindbyID() async {

    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');
    final url = Uri.parse('http://localhost:8080/register-person/find/$idPessoa');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 
        'Authorization': 'Bearer $token',
      },
        
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        Pessoa pessoa = Pessoa.fromJson(jsonData);
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
