import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/schedule_list_service.dart';
import 'package:prognosticare/src/models/schedule_model.dart';
import 'package:prognosticare/src/pages/schedule/schedule_screen.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({super.key});

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  List<Schedule> scheduleList = [];
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  // Combo box para selecionar o tipo de agendamento
                  DropdownButtonFormField<String>(
                    value: tipoSelecionado,
                    onChanged: (newValue) {
                      setState(() {
                        tipoSelecionado = newValue;
                      });
                    },
                    items: tiposDeAgendamento.map((tipo) {
                      return DropdownMenuItem<String>(
                        value: tipo,
                        child: Text(tipo),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Tipo de Agendamento',
                      hintText: 'Selecione um tipo de agendamento...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Verifique se um tipo de agendamento foi selecionado
                        if (tipoSelecionado != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleScreen(),
                            ),
                          );
                        } else {
                          // Caso contrário, mostre um aviso ao usuário
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Por favor, selecione um tipo de agendamento.'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                        alignment: Alignment.center,
                      ),
                      child: Container(
                        width: 465,
                        height: 39,
                        child: Center(child: Text('+ AGENDAR')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
