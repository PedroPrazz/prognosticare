import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/schedule_model.dart';

final storage = FlutterSecureStorage();

class ScheduleService {
  static Future<bool> getSchedule(Schedule schedule) async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    final url =
        Uri.parse(UriServidor.url.toString() + '/to-scheduling/save/$idPessoa');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'dataAgenda': schedule.dataAgenda,
          'local': schedule.local,
          'descricao': schedule.descricao,
          'observacao': schedule.observacao,
          'especialista': schedule.especialista,
          'tipoExame': schedule.tipoAgendamento,
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
}
