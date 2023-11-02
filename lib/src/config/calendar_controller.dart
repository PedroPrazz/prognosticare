import 'package:get/get.dart';
import 'package:prognosticare/src/api/service/accompany_service.dart';
import 'package:prognosticare/src/api/service/schedule_service.dart';
import 'package:prognosticare/src/models/schedule_model.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  late DateTime primeiroDia;
  late DateTime ultimoDia;
  late DateTime diaAtual;
  late String filtro;

  Map<DateTime, List<String>> eventos =
      {}; // Mapeia datas para uma lista de eventos

  List<Schedule> agendamentos = [];
  List<Accompany> acompanhamentos = [];

  CalendarFormat calendarFormat = CalendarFormat.month;

  String locale = 'pt-BR';

  @override
  void onInit() async {
    primeiroDia = DateTime.now().add(Duration(days: -365));
    ultimoDia = DateTime.now().add(Duration(days: 365));
    diaAtual = DateTime.now();

    getEventosDia(diaAtual);

    super.onInit();
  }

  Future getEventosDia(data) async {
    diaAtual = data;
    getAgenda(data);
    update(['calendario', 'agenda']);
  }

  Future<void> getAgenda(DateTime data) async {
    eventos.clear();

    // Busque os agendamentos para a data especificada
    DateTime dataInicial = data;
    DateTime dataFinal = data.add(Duration(days: 1)); // Próximo dia

    try {
      agendamentos =
          await ScheduleService.getScheduleListBetween(dataInicial, dataFinal);

      // Busque os acompanhamentos para a data especificada
      acompanhamentos = await AccompanyService.getAccompanyListBetween(
          dataInicial, dataFinal);

      // Crie uma lista de eventos que combina agendamentos e acompanhamentos
      List<String> eventsForTheDay = [];

      for (var schedule in agendamentos) {
        String evento = '${schedule.dataAgenda} - ${schedule.tipoAgendamento}';
        eventsForTheDay.add(evento);
      }

      for (var accompany in acompanhamentos) {
        String evento =
            '${accompany.dataAcompanhamento} - ${accompany.tipoAcompanhamento}';
        eventsForTheDay.add(evento);
      }

      eventos[data] = eventsForTheDay;

      update(['calendario', 'agenda']);
    } catch (e) {
      print('Erro ao buscar agendamentos e acompanhamentos: $e');
    }
  }

  void onFormatChanged(format) {
    calendarFormat = format;

    update(['calendario']);
  }

  void updateEventsForDay(DateTime date, List<String> events) {
    eventos[date] = events;
    update(['calendario', 'agenda']);
  }
}
