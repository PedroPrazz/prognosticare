import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/schedule_model.dart';

final storage = FlutterSecureStorage();

class ScheduleService {

  //Método para criar um agendamento

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
          'notificacao':schedule.notificacao,
          'intervaloData': schedule.intervaloData,
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

  //Método get para listar agendamentos

  static Future<List<Schedule>> getScheduleList() async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    final url =
        Uri.parse(UriServidor.url.toString() + '/to-scheduling/list/$idPessoa');

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

        List<Schedule> schedules = jsonDataList.map((jsonData) {
          return Schedule.fromJson(jsonData);
        }).toList();

        return schedules;
      } else {
        print('Response Status Code: ${response.statusCode}');
        throw Exception('Exeption no método find');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Exeption no método find Erro no Try/Catch');
    }
  }

  //Método para atualizar agendamentos

  static Future<bool> updateSchedule(Schedule schedule) async {
    String? token = await storage.read(key: 'token');
    final url = Uri.parse(
        UriServidor.url.toString() + '/to-scheduling/update');

    try {
      final response = await http.put(
        url,
        body: json.encode({
          'id': schedule.id,
          'dataAgenda': schedule.dataAgenda,
          'local': schedule.local,
          'statusEvento': schedule.statusEvento,
          'descricao': schedule.descricao,
          'intervaloData': schedule.intervaloData,
          'notificacao': schedule.notificacao,
          'observacao': schedule.observacao,
          'especialista': schedule.especialista,
          'tipoExame': schedule.tipoAgendamento,
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

        throw Exception('Erro ao atualizar Agendamento');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Erro de Try Catch ao atualizar Agendamento');
    }
  }

  static Future<bool> updateStatus(Schedule schedule) async {
    String? token = await storage.read(key: 'token');

    final url = Uri.parse(UriServidor.url.toString() +
        '/to-scheduling/update-status/' +
        (schedule.id ?? ''));

    try {
      final response = await http.put(
        url,
        body: json.encode({
          'statusEvento': schedule.statusEvento,
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

        throw Exception('Erro ao atualizar Agendamento');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Erro de Try Catch ao atualizar Agendamento');
    }
  }

  static Future<List<Schedule>> getScheduleListByFiltro(String filtro) async {
     String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    DateTime now = DateTime.now();
    String formattedDate = DateFormat("dd/MM/yyyy hh:mm:ss a").format(now);

    final url =
        Uri.parse(UriServidor.url.toString() + '/to-scheduling/list-day/$idPessoa?filtro=$filtro&dataInicial=$formattedDate');
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

        List<Schedule> schedules = jsonDataList.map((jsonData) {
          return Schedule.fromJson(jsonData);
        }).toList();

        return schedules;
      } else {
        print('Response Status Code: ${response.statusCode}');
        throw Exception('Exeption no método getScheduleListByFiltro');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Exeption no método find Erro no Try/Catch');
    }
  }

  //Método get para listar agendamentos entre dias
  static Future<List<Schedule>> getScheduleListBetween(DateTime dataInicial, DateTime dataFinal) async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    String formattedDataInicial = DateFormat("dd/MM/yyyy hh:mm:ss a").format(dataInicial);
    String formattedDataFinal = DateFormat("dd/MM/yyyy hh:mm:ss a").format(dataFinal);

    final url = Uri.parse(
        UriServidor.url.toString() + '/to-scheduling/between-days/$idPessoa?dataInicial=$formattedDataInicial&dataFinal=$formattedDataFinal');
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

        List<Schedule> schedules = jsonDataList.map((jsonData) {
          return Schedule.fromJson(jsonData);
        }).toList();

        return schedules;
      } else {
        print('Response Status Code: ${response.statusCode}');
        throw Exception('Exeption no método getScheduleListBetween');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Exeption no método find Erro no Try/Catch');
    }
  }

}
