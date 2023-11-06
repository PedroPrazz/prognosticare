import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/schedule_service.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/schedule_model.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';
import 'package:prognosticare/src/pages/schedule/schedule_screen.dart';

class ScheduleListScreen extends StatefulWidget {
  ScheduleListScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late Future<List<Schedule>> schedulesFuture;
  bool isAgendamentoConfirmado = false;

  @override
  void initState() {
    super.initState();
    schedulesFuture = ScheduleService.getScheduleList();
  }

  // Função para exibir o AlertDialog de confirmação
  Future<void> _confirmarAgendamento(Schedule schedule) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Agendamento'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você deseja confirmar o Agendamento:'),
                Text(schedule.tipoAgendamento),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                setState(() {
                  isAgendamentoConfirmado = true;
                  schedule.statusEvento = "FINALIZADO";
                  ScheduleService.updateStatus(schedule);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((value) => setState(
          () {
            isAgendamentoConfirmado = true;
          },
        ));
  }

  Future<void> _confirmarExclusao(
      Schedule schedule, AsyncSnapshot<List<Schedule>> snapshot) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você deseja excluir o Agendamento:'),
                Text(schedule.tipoAgendamento),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                schedule.statusEvento = "CANCELADO";
                ScheduleService.updateStatus(schedule);
                setState(() {
                  snapshot.data!.remove(schedule);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((value) => setState(() {
          isAgendamentoConfirmado = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
          },
        ),
        title: Text('Agendamentos'),
        centerTitle: true,
        backgroundColor: CustomColors.customSwatchColor,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Schedule>>(
        future: schedulesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Sem agendamentos na lista'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum agendamento encontrado'));
          } else {
            final schedules = snapshot.data!;
            return ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                schedules.sort((a, b) {
                  // A ordem desejada é "ABERTO" > "FINALIZADO" > "CANCELADO"
                  if (a.statusEvento == "ABERTO" &&
                      (b.statusEvento == "FINALIZADO" ||
                          b.statusEvento == "CANCELADO")) {
                    return -1; // "ABERTO" vem antes de "FINALIZADO" ou "CANCELADO"
                  } else if (a.statusEvento == "FINALIZADO" &&
                      b.statusEvento == "CANCELADO") {
                    return -1; // "FINALIZADO" vem antes de "CANCELADO"
                  } else if (a.statusEvento == b.statusEvento) {
                    return 0; // Mesmo status, sem mudança na ordem
                  } else {
                    return 1; // Qualquer outra combinação
                  }
                });
                final schedule = schedules[index];
                Color statusColor = schedule.statusEvento == "ABERTO"
                    ? Colors.green
                    : Colors.red; // Define a cor com base no status
                isAgendamentoConfirmado = schedule.statusEvento == "FINALIZADO";
                return ListTile(
                  title: Text(
                      schedule.tipoAgendamento + " " + schedule.especialista),
                  subtitle: Text(
                    schedule.statusEvento!,
                    style: TextStyle(color: statusColor),
                  ),
                  leading: schedule.statusEvento == "ABERTO"
                      ? IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (c) {
                                return ScheduleScreen(
                                  schedule: schedule,
                                  isEditing: true, // Modo de edição ativado
                                );
                              },
                            ));
                          },
                        )
                      : Icon(Icons.health_and_safety),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: schedule.statusEvento == "ABERTO" || schedule.statusEvento == "FINALIZADO",
                        child: IconButton(
                        icon: isAgendamentoConfirmado
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.radio_button_unchecked),
                        onPressed: () {
                          if (schedule.statusEvento == "ABERTO") {
                            _confirmarAgendamento(schedule);
                          }
                        },
                      ),),
                      
                      Visibility(
                        visible: schedule.statusEvento != "CANCELADO",
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            _confirmarExclusao(schedule,
                                snapshot); // Abre o diálogo de confirmação
                          },
                        ),
                      ),
                    ],
                  ),
                  onTap: () {},
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
