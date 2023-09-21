import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/scheduleListService.dart';
import 'package:prognosticare/src/models/schedule_model.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({super.key});

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  List<Schedule> scheduleList = [];

  @override
  void initState() {
    super.initState();
    loadScheduleList();
  }

  Future<void> loadScheduleList() async {
    try {
      Schedule schedule = await ScheduleListService.getScheduleList();
      setState(() {
        scheduleList.add(schedule);
      });
    } catch (e) {
      // Trate os erros de carregamento aqui, exibindo uma mensagem de erro, por exemplo.
      print('Erro ao carregar agendamentos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Agendamentos'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(255, 143, 171, 1),
          foregroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemCount: scheduleList.length,
          itemBuilder: (context, index) {
            Schedule schedule = scheduleList[index];
            return ListTile(
              title: Text(schedule.descricao ?? ''),
              // Exiba outras informações do agendamento aqui.
            );
          },
        ),
      ),
    );
  }
}
