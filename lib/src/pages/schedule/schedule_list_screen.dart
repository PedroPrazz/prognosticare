import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/schedule_list_service.dart';
import 'package:prognosticare/src/models/schedule_model.dart';
import 'package:prognosticare/src/pages/schedule/schedule_screen.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late Future<List<Schedule>> schedulesFuture;

  String? tipoSelecionado;
  List<String> tiposDeAgendamento = [
    'Exames',
    'Consultas',
    'Internações',
    'Vacinas',
    'Cirurgias'
  ];

  @override
  void initState() {
    super.initState();
    schedulesFuture = ScheduleListService.getScheduleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: FutureBuilder<List<Schedule>>(
        future: schedulesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar a lista de agendamentos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum agendamento encontrado'));
          } else {
            final schedules = snapshot.data!;
            return ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];
                return ListTile(
                  title: Text(schedule.descricao),
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                     Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (c) {
                            return ScheduleScreen(
                              schedule: schedule,
                              isEditing: true, // Modo de edição ativado
                            );
                          },
                        ));
                      },
                  ),
                  // Verifique se o agendamento foi realizado e exiba um ícone correspondente.
                  trailing: schedule.realizado != null
                      ? Icon(Icons.check_circle,
                          color: Colors.green) // Agendamento realizado
                      : Icon(Icons
                          .radio_button_unchecked), // Agendamento não realizado
                  onTap: () {
                    // Ao tocar no agendamento, exiba o AlertDialog de confirmação
                    _confirmarAgendamento(schedule);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (c) {
              return ScheduleScreen();
            },
          ));
        },
        label: Text(
          'AGENDAR',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
