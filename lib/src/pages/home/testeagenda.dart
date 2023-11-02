
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:prognosticare/src/config/calendar_controller.dart';
// import 'package:prognosticare/src/config/custom_colors.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarScreen extends GetView<CalendarController> {
//   const CalendarScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildCalendar(),
//       appBar: AppBar(
//         title: Text('Calendário'),
//         centerTitle: true,
//         foregroundColor: Colors.white,
//       ),
//     );
//   }

//   Widget _buildCalendar() {
//     return GetBuilder<CalendarController>(
//       id: 'calendario',
//       builder: (context) {
//         return Column(
//           children: [
//             Container(
//               child: TableCalendar(
//                 firstDay: controller.primeiroDia,
//                 lastDay: controller.ultimoDia,
//                 focusedDay: controller.diaAtual,
//                 selectedDayPredicate: (day) =>
//                     isSameDay(day, controller.diaAtual),
//                 onDaySelected: (dayInicio, dayFim) async {
//                   controller.getEventosDia(dayInicio);
//                 },
//                 locale: controller.locale,
//                 calendarFormat: controller.calendarFormat,
//                 onFormatChanged: (day) => controller.onFormatChanged(day),
//                 headerStyle: HeaderStyle(
//                     titleCentered: true,
//                     formatButtonVisible: false,
//                     titleTextStyle: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: CustomColors.customSwatchColor),
//                     titleTextFormatter: (day, locale) =>
//                         DateFormat('MMMM yyyy', locale)
//                             .format(day)
//                             .capitalize!),
//                 calendarStyle: CalendarStyle(
//                   defaultTextStyle: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                   weekendTextStyle: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                   todayDecoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: CustomColors.customContrastColor),
//                   selectedTextStyle: TextStyle(
//                     color: Colors.white,
//                     fontWeight: isSameDay(DateTime.now(), controller.diaAtual)
//                         ? FontWeight.normal
//                         : FontWeight.bold,
//                     fontSize: isSameDay(DateTime.now(), controller.diaAtual)
//                         ? 16
//                         : 14,
//                   ),
//                   selectedDecoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: CustomColors.customSwatchColor.shade700,
//                   ),
//                 ),
//               ),
//             ),
//             Flexible(child: _buildAgenda(controller.diaAtual))
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildAgenda(DateTime data) {
//   return GetBuilder<CalendarController>(
//     id: 'agenda',
//     builder: (context) {
//       return controller.eventos.isEmpty
//           ? Container(
//               margin: EdgeInsets.only(top: 20),
//               child: Column(
//                 children: [
//                   Text(
//                     'Você não tem eventos neste dia',
//                     style: TextStyle(fontSize: 30),
//                   ),
//                 ],
//               ),
//             )
//           : Container(
//               padding: EdgeInsets.all(6),
//               child: Column(
//                 children: [
//                   Flexible(
//                     child: SizedBox(
//                       height: 60,
//                       width: 60,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.orange,
//                         child: Text(
//                           data.day.toString(),
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     flex: 2,
//                     child: ListView.builder(
//                       itemCount: DateTime(data.year, data.month + 1, 0).day,
//                       itemBuilder: (BuildContext context, int dayIndex) {
//                         final day =
//                             DateTime(data.year, data.month, dayIndex + 1);
//                         final eventsForTheDay = controller.eventos[day] ?? [];

//                         return Card(
//                           child: Column(
//                             children: [
//                               ListTile(
//                                 title: Text(
//                                   DateFormat('d/M/y').format(day),
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               for (var event in eventsForTheDay)
//                                 ListTile(
//                                   title: Text(
//                                     event,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//     },
//   );
// }
// }
