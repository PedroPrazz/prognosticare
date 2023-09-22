import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/schedule_model.dart';

final storage = FlutterSecureStorage();

class ScheduleListService {
  static Future<Schedule> getScheduleList() async {
    String? idPessoa = await storage.read(key: 'user_id');

    final url =
        Uri.parse(UriServer.url.toString() + '/to-scheduling/list/$idPessoa');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        Schedule schedule = Schedule.fromJson(jsonData);

        return schedule;
      } else {
        print('Response Status Code: ${response.statusCode}');
        throw Exception('Exeption no método find');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Exeption no método find Erro no Try/Catch');
    }
  }
}
