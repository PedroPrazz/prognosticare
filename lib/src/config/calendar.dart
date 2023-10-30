// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:prognosticare/src/api/service/accompany_service.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarController extends GetxController {
//   late DateTime primeiroDia;
//   late DateTime ultimoDia;
//   late DateTime diaAtual;
//   late String filtro;

//   List<String> agenda = [];

//   CalendarFormat calendarFormat = CalendarFormat.month;

//   String locale = 'pt-BR';

//   @override
//   void onInit() async {
//     primeiroDia = DateTime.now().add(Duration(days: -365));
//     ultimoDia = DateTime.now().add(Duration(days: 365));
//     diaAtual = DateTime.now();

//     getEventosDia(diaAtual);

//     super.onInit();
//   }

//   Future getEventosDia(DateTime data) async {
//   diaAtual = data;
//   getAgenda(data.toLocal().toIso8601String()); // Converte o DateTime para uma String no formato ISO8601
//   update(['calendario', 'agenda']);
// }


//   // void getAgenda(DateTime data) {
//   //   agenda.clear();

//   //   if (data.day == 27) {
//   //     agenda = ['08:00 : jashfios'];
//   //   } else if (data.day == 28) {
//   //     agenda = ['10:05: afasfAF'];
//   //   }
//   // }

//   void getAgenda(String dataAcompanhamento) async {
//   // Limpa a lista atual
//   agenda.clear();

//   try {
//     // Converte a string em um objeto DateTime
//     final data = DateTime.parse(dataAcompanhamento);

//     // Faça uma solicitação à API para obter a lista de agendamentos
//     final accompanyList = await AccompanyService.getAccompanyListByFiltro();

//     // Filtre os agendamentos com base na data
//     final filteredAgenda = accompanyList.where((accompany) {
//       final acompanhamentoDate = DateTime.parse(accompany.dataAcompanhamento);
//       return isSameDay(acompanhamentoDate, data);
//     }).toList();

//     // Adicione os agendamentos filtrados à lista
//     filteredAgenda.forEach((accompany) {
//       agenda.add(
//         DateFormat('HH:mm : ').format(DateTime.parse(accompany.dataAcompanhamento)) +
//             accompany.tipoAcompanhamento,
//       );
//     });

//     // Atualize os widgets que usam a lista de agendamentos
//     update(['calendario', 'agenda']);
//   } catch (e) {
//     print('Erro ao obter a lista de agendamentos da API: $e');
//   }
// }

//   void onFormatChanged(format){
//     calendarFormat = format;

//     update(['calendario']);
//   }
// }
