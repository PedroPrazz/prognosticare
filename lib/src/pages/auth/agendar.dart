import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prognosticare/src/api/service/schedule.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';

class Agendar extends StatefulWidget {
  Agendar(String? tipoSelecionado, {super.key});

  @override
  State<Agendar> createState() => _AgendarState();
}

// class AgendamentoModel {
//   final String especialista;
//   final String descricao;
//   final String dataHorario;
//   final String local;
//   final String observacoes;

//   AgendamentoModel({
//     required this.especialista,
//     required this.descricao,
//     required this.dataHorario,
//     required this.local,
//     required this.observacoes,
//   });
// }

// Crie um provedor para as informações do agendamento
// class AgendamentoProvider with ChangeNotifier {
//   AgendamentoModel? _agendamento;

//   AgendamentoModel? get agendamento => _agendamento;

//   void setAgendamento(AgendamentoModel agendamento) {
//     _agendamento = agendamento;
//     notifyListeners();
//   }
// }

class _AgendarState extends State<Agendar> {
  @override
  bool realizado = false;

  Widget build(BuildContext context) {
    TextEditingController _especialista = TextEditingController();
    TextEditingController _descricao = TextEditingController();
    TextEditingController _local = TextEditingController();
    TextEditingController _dataHorario = TextEditingController();
    TextEditingController _observacoes = TextEditingController();
    TextEditingController _tipoExame = TextEditingController();
    TextEditingController _intervalo = TextEditingController();
    // final AgendamentoProvider _agendamentoProvider = AgendamentoProvider();

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
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: 500,
                    child: TextFormField(
                      controller: _especialista,
                      decoration: InputDecoration(
                          labelText: 'Especialista',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(255, 143, 171, 1)))),
                      cursorColor: Color.fromRGBO(255, 143, 171, 1),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Especialista is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 500,
                    child: TextFormField(
                      controller: _descricao,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                          labelText: 'Descrição',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(255, 143, 171, 1)))),
                      cursorColor: Color.fromRGBO(255, 143, 171, 1),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Descrição is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 500,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        // DataInputFormatter(),
                      ],
                      controller: _dataHorario,
                      decoration: InputDecoration(
                          labelText: 'Data | Horário',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(255, 143, 171, 1)))),
                      cursorColor: Color.fromRGBO(255, 143, 171, 1),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data | Horário is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 500,
                    child: TextFormField(
                      controller: _local,
                      decoration: InputDecoration(
                          labelText: 'Local',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(255, 143, 171, 1)))),
                      cursorColor: Color.fromRGBO(255, 143, 171, 1),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Local is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 500,
                    child: TextFormField(
                      controller: _observacoes,
                      decoration: InputDecoration(
                          labelText: 'Observações',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(255, 143, 171, 1)))),
                      cursorColor: Color.fromRGBO(255, 143, 171, 1),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Observações is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Alinha à esquerda
                    children: [
                      Checkbox(
                        value: realizado,
                        onChanged: (bool? value) {
                          setState(() {
                            realizado = value!;
                          });
                        },
                        checkColor: Color.fromRGBO(255, 143, 171, 1),
                      ),
                      Text('Foi Realizado?'),
                    ],
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      bool agendar = await ScheduleService.getSchedule(
                          _dataHorario.text,
                          _local.text,
                          _descricao.text,
                          _observacoes.text,
                          _especialista.text,
                          _tipoExame.text,
                          _intervalo.text);
                      if (agendar) {
                        // _agendamentoProvider.setAgendamento(AgendamentoModel(
                        //   especialista: _especialista.text,
                        //   descricao: _descricao.text,
                        //   dataHorario: _dataHorario.text,
                        //   local: _local.text,
                        //   observacoes: _observacoes.text,
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (c) {
                          return HomeScreen();
                        }));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                      alignment: Alignment.center,
                    ),
                    child: Container(
                        width: 465,
                        height: 39,
                        child: Center(child: Text('AGENDAR'))),
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
