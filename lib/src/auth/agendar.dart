import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Agendar extends StatefulWidget {
  const Agendar(String? tipoSelecionado, {super.key});

  @override
  State<Agendar> createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  @override
  bool realizado = false;

  Widget build(BuildContext context) {
    TextEditingController _especialista = TextEditingController();
    TextEditingController _descricao = TextEditingController();
    TextEditingController _local = TextEditingController();
    TextEditingController _dataHorario = TextEditingController();
    TextEditingController _observacoes = TextEditingController();

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
                    onPressed: () async {},
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
