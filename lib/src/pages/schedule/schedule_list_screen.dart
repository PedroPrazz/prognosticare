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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
              Expanded(
                child: FutureBuilder<List<Schedule>>(
                  future: schedulesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child:
                              Text('Erro ao carregar a lista de agendamentos'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text('Nenhum agendamento encontrado'));
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
                                // Coloque aqui a lógica para editar o dependente
                              },
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Coloque aqui a lógica para excluir o dependente
                              },
                            ),
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (c) {
                              //     return ProfileTabDepentende();
                              //   },
                              // ));
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Spacer(), // Espaço flexível para empurrar o botão para a parte inferior
              ElevatedButton(
                onPressed: () async {
                  // Verifique se um tipo de agendamento foi selecionado
                  if (tipoSelecionado != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (c) {
                          return ScheduleScreen();
                        },
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
                ),
                child: Container(
                  width: double
                      .infinity, // Largura do botão definida para ocupar a largura máxima
                  height: 39,
                  child: Center(child: Text('+ AGENDAR')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
