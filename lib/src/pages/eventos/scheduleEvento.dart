// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/schedule_service.dart';
import 'package:prognosticare/src/models/schedule_model.dart';

class Events extends StatefulWidget {
  String filtro;
  Events({Key? key, required this.filtro}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late Future<List<Schedule>> schedulesFuture;
  TextEditingController searchController = TextEditingController();
  List<Schedule> allSchedules = [];

  @override
  void initState() {
    super.initState();
    schedulesFuture = ScheduleService.getScheduleListByFiltro(widget.filtro);
    schedulesFuture.then((schedules) {
      setState(() {
        allSchedules = schedules;
      });
    });
  }

  List<Schedule> getFilteredSchedules(String query, String filtro) {
    return allSchedules.where((schedule) {
      final tipoEspecialista =
          schedule.tipoAgendamento + " " + schedule.especialista;
      return tipoEspecialista.toLowerCase().contains(query.toLowerCase());
    }).toList()
      ..sort((a, b) {
        if (filtro == 'maior') {
          return DateTime.parse(b.dataAgenda!)
              .compareTo(DateTime.parse(a.dataAgenda!));
        } else if (filtro == 'igual') {
          return a.statusEvento!.compareTo(b.statusEvento!);
        } else if (filtro == 'menor') {
          return DateTime.parse(a.dataAgenda!)
              .compareTo(DateTime.parse(b.dataAgenda!));
        } else {
          // Caso de filtro desconhecido
          return 0;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  schedulesFuture =
                      Future.value(getFilteredSchedules(value, ''));
                });
              },
              decoration: InputDecoration(
                hintText: 'Digite para pesquisar...',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Schedule>>(
              future: schedulesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Sem eventos cadastrados.',
                      style: TextStyle(fontSize: 25, color: Colors.blue),
                    ),
                  );
                } else {
                  List<Schedule> schedules = snapshot.data!;
                  return ListView.builder(
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      final schedule = schedules[index];
                      Color statusColor = schedule.statusEvento == "ABERTO"
                          ? Colors.green
                          : Colors.red;
                      return ListTile(
                        title: Text(
                            schedule.tipoAgendamento +
                                " " +
                                schedule.especialista,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: Text(
                          schedule.statusEvento! + " " + schedule.dataAgenda,
                          style: TextStyle(color: statusColor),
                        ),
                        onTap: () {},
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
