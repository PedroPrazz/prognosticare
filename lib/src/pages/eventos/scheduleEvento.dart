// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/schedule_service.dart';
import 'package:prognosticare/src/models/schedule_model.dart';

class ScheduleEvento extends StatefulWidget {
  String filtro;

  ScheduleEvento({Key? key, required this.filtro}) : super(key: key);

  @override
  _CarrinhoPageState createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<ScheduleEvento> {
  late Future<List<Schedule>> schedulesFuture;

  @override
  void initState() {
    super.initState();
    schedulesFuture = ScheduleService.getScheduleListByFiltro(widget.filtro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Schedule>>(
      future: schedulesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          List<Schedule> schedules = snapshot.data!;
          return ListView.builder(
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final schedule = schedules[index];
              schedules.sort((a, b) {
                if (a.statusEvento == "ABERTO" &&
                    (b.statusEvento == "FINALIZADO" ||
                        b.statusEvento == "CANCELADO")) {
                  return -1;
                } else if (a.statusEvento == "FINALIZADO" &&
                    b.statusEvento == "CANCELADO") {
                  return -1;
                } else if (a.statusEvento == b.statusEvento) {
                  return 0;
                } else {
                  return 1;
                }
              });

              Color statusColor =
                  schedule.statusEvento == "ABERTO" ? Colors.green : Colors.red;
              return ListTile(
                title: Text(
                    schedule.tipoAgendamento + " " + schedule.especialista),
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

    );
  }
}
