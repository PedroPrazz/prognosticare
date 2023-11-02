import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prognosticare/src/api/service/accompany_service.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';
import 'package:table_calendar/table_calendar.dart';

// ... Seu código existente ...

class ToAccompanyScreenEvent extends StatefulWidget {
  // ... Seu código existente ...

  @override
  State<ToAccompanyScreenEvent> createState() => _ToAccompanyScreenEventState();
}
class _ToAccompanyScreenEventState extends State<ToAccompanyScreenEvent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Accompany>> _events = {};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    loadAccompaniments(startOfMonth, endOfMonth);
  }

  Future<void> loadAccompaniments(DateTime startDate, DateTime endDate) async {
    try {
      final accompaniments = await AccompanyService.getAccompanyListBetween(startDate, endDate);
      for (var accompany in accompaniments) {
        DateFormat apiDateFormat = DateFormat("dd/MM/yyyy HH:mm:ss a");
        final DateTime accompanyDate = apiDateFormat.parse(accompany.dataAcompanhamento);
        if (_events[accompanyDate] == null) {
          _events[accompanyDate] = [accompany];
        } else {
          _events[accompanyDate]!.add(accompany);
        }
      }
      setState(() {});
    } catch (e) {
      print('Erro ao carregar os acompanhamentos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2101),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              // Chama esta função toda vez que o usuário muda de mês
              final startOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
              final endOfMonth = DateTime(focusedDay.year, focusedDay.month + 1, 0);
              loadAccompaniments(startOfMonth, endOfMonth);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
          ),
          if (_selectedDay != null)
            ...(_events[_selectedDay] ?? []).map((accompany) {
              return ListTile(
                title: Text(accompany.tipoAcompanhamento),
                subtitle: Text(accompany.medicacao),
              );
            }).toList(),
        ],
      ),
    );
  }

  List<Accompany> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }
}
