// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/src/api/service/schedule_service.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/schedule_model.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';
import 'package:prognosticare/src/pages/schedule/schedule_list_screen.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class ScheduleScreen extends StatefulWidget {
  final Schedule? schedule;
  bool isEditing;

  ScheduleScreen({Key? key, this.schedule, this.isEditing = false})
      : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // Lista de tipos de agendamentos
  List<String> tiposDeAgendamento = [
    'Exames',
    'Consultas',
    'Internações',
    'Vacinas',
    'Cirurgias'
  ];
  List<int> intervaloData = [1, 2, 3, 5];

  int selectValue = 2;

  // Variável para armazenar o valor selecionado na combo box
  String? tipoSelecionado;

  final dataFormatter = MaskTextInputFormatter(
    mask: '##/##/#### ##:##', // Define a máscara como 'dd/MM/yyyy HH:mm'
    filter: {"#": RegExp(r'[0-9]')}, // Define os caracteres permitidos
  );

  TextEditingController especialistaController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController localController = TextEditingController();
  TextEditingController datahController = TextEditingController();
  TextEditingController obsController = TextEditingController();
  TextEditingController tipoAgendamentoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool especialistaValido = false;
  bool descricaoValido = false;
  bool localValido = false;
  bool datahValido = false;
  bool obsValido = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      tipoAgendamentoController.text = widget.schedule!.tipoAgendamento;
      especialistaController.text = widget.schedule!.especialista;
      descricaoController.text = widget.schedule!.descricao;
      localController.text = widget.schedule!.local;
      datahController.text = widget.schedule!.dataAgenda;
      obsController.text = widget.schedule!.observacao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Editar Agendamento' : 'Adicionar Agendamento',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                width: 300,
                child: DropdownButtonFormField<String>(
                  focusColor: Colors.white,
                  decoration: InputDecoration(
                    hoverColor: Colors.blue,
                    labelText: 'Tipo de Agendamento',
                    labelStyle: TextStyle(color: Colors.black),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: CustomColors.customSwatchColor,
                      ),
                    ),
                  ),
                  value: tipoAgendamentoController.text.isEmpty
                      ? null
                      : tipoAgendamentoController.text,
                  onChanged: (String? newValue) {
                    setState(() {
                      tipoAgendamentoController.text = newValue!;
                    });
                  },
                  items: <String>[
                    'EXAME',
                    'CONSULTA',
                    'INTERNAÇÃO',
                    'VACINA',
                    'CIRURGIA',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(Icons.library_books,
                              color: CustomColors.customSwatchColor),
                          SizedBox(width: 10),
                          Text(
                            value,
                            style: TextStyle(
                              color: CustomColors.customSwatchColor,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            //Especialista
            CustomTextField(
              controller: especialistaController,
              icon: Icons.person,
              label: 'Especialista',
              validator: (especialista) {
                if (especialista == null || especialista.trim().isEmpty) {
                  return 'Informe um especialista entre: ORTOPEDIA, CLINICO_GERAL, CARDIOLOGIA, \nGINECOLOGIA, DERMATOLOGIA ou NAO_POSSUI!';
                }
                // if (!especialista.trim().contains('ORTOPEDIA') ||
                //     !especialista.trim().contains('CLINICO_GERAL') ||
                //     !especialista.trim().contains('CARDIOLOGIA') ||
                //     !especialista.trim().contains('GINECOLOGIA') ||
                //     !especialista.trim().contains('NAO_POSSUI') ||
                //     !especialista.trim().contains('DERMATOLOGIA')) {
                //   return 'Informe um especialista entre: ORTOPEDIA, CLINICO_GERAL, CARDIOLOGIA, \nGINECOLOGIA, DERMATOLOGIA ou NAO_POSSUI!';
                // }
                especialistaValido = true;
                return null;
              },
            ),
            //Descrição
            CustomTextField(
              controller: descricaoController,
              icon: Icons.description,
              label: 'Descrição',
              validator: (descricao) {
                if (descricao == null || descricao.trim().isEmpty) {
                  return 'Informe uma descrição!';
                }
                if (descricao.trim().length < 3) {
                  return 'Descrição deve ter no mínimo 3 caracteres!';
                }
                descricaoValido = true;
                return null;
              },
            ),
            //Local
            CustomTextField(
              controller: localController,
              icon: Icons.location_on,
              label: 'Local',
              validator: (local) {
                if (local == null || local.trim().isEmpty) {
                  return 'Informe um local!';
                }
                if (local.trim().length < 3) {
                  return 'Local deve ter no mínimo 3 caracteres!';
                }
                localValido = true;
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: DateTimeField(
                format: DateFormat("dd/MM/yyyy HH:mm a"),
                controller: datahController,
                inputFormatters: [dataFormatter],
                decoration: InputDecoration(
                  labelText: 'Data | Horário',
                  prefixIcon: Icon(Icons.date_range),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: CustomColors.customSwatchColor,
                    ),
                  ),
                ),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                    context: context,
                    initialDate: currentValue ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      ).then((selectedTime) {
                        if (selectedTime != null) {
                          final selectedDateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                          datahController.text =
                              DateFormat("dd/MM/yyyy hh:mm a")
                                  .format(selectedDateTime);
                          return selectedDateTime;
                        } else {
                          return currentValue;
                        }
                      });
                    } else {
                      return currentValue;
                    }
                  });
                },
                validator: (dateTime) {
                  if (dateTime == null) {
                    return 'Informe uma data e horário!';
                  }
                  datahValido = true;
                  return null;
                },
              ),
            ),
            //Data e Horário
            // CustomTextField(
            //   controller: datahController,
            //   icon: Icons.date_range,
            //   label: 'Data | Horário',
            //   inputFormatters: [dataFormatter],
            //   validator: (data) {
            //     if (data == null || data.trim().isEmpty) {
            //       return 'Informe uma data e horário!';
            //     }
            //     if (data.toString().trim().length > 0 &&
            //         data.toString().trim().length < 16) {
            //       return 'Informe data e horário no formato: dd/mm/aaaa hh:mm';
            //     }
            //     // DateTime dataAtual = DateTime.now();
            //     // DateTime dataInserida =
            //     //     DateFormat('dd/MM/yyyy HH:mm').parse(data.trim());
            //     // if (!dataInserida.isBefore(dataAtual) ||
            //     //     !dataInserida.isAfter(dataAtual)) {
            //     //   return 'Data e/ou Horário inválido(s)!';
            //     // }
            //     datahValido = true;
            //     return null;
            //   },
            // ),
            //Observações
            CustomTextField(
              controller: obsController,
              icon: Icons.description,
              label: 'Observações',
              validator: (observacao) {
                if (observacao == null || observacao.trim().isEmpty) {
                  return 'Informe uma observação!';
                }
                if (observacao.trim().length < 3) {
                  return 'Observação deve ter no mínimo 3 caracteres!';
                }
                obsValido = true;
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                width: 300,
                child: DropdownButtonFormField<int>(
                  focusColor: Colors.white,
                  decoration: InputDecoration(
                    hoverColor: Colors.blue,
                    labelText: 'Intervalo de Horas',
                    labelStyle: TextStyle(color: Colors.black),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: CustomColors.customSwatchColor,
                      ),
                    ),
                  ),
                  value: selectValue,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectValue = newValue ?? 2;
                    });
                  },
                  items: intervaloData.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(
                            Icons.library_books,
                            color: CustomColors.customSwatchColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            value.toString(),
                            style: TextStyle(
                              color: CustomColors.customSwatchColor,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // Botão de Agendar
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print('Todos os campos estão válidos');
                  } else {
                    print('Campos não válidos');
                  }
                  if (!especialistaValido ||
                      !descricaoValido ||
                      !localValido ||
                      !datahValido ||
                      !obsValido) {
                    return;
                  }
                  final selectedDateTime = DateFormat("dd/MM/yyyy HH:mm a").parse(datahController.text.trim());
                  final formattedDateTime = DateFormat("dd/MM/yyyy hh:mm:ss a").format(selectedDateTime);
                  final intervalo = selectValue;

                  if (widget.isEditing == true) {
                    final schedule = Schedule.editar(
                      id: widget.schedule!.id,
                      dataAgenda: formattedDateTime,
                      local: localController.text.trim(),
                      descricao: descricaoController.text.trim(),
                      observacao: obsController.text.trim(),
                      especialista: especialistaController.text.trim(),
                      tipoAgendamento: tipoAgendamentoController.text.trim(),
                      intervaloData: intervalo
                    );
                    bool update =
                        await ScheduleService.updateSchedule(schedule);
                    if (update) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Agendamento atualizado com sucesso!',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (c) {
                          return ScheduleListScreen();
                        },
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Erro no servidor abraço, tente depois',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    final schedule = Schedule.cadastrar(
                      dataAgenda: formattedDateTime,
                      local: localController.text.trim(),
                      descricao: descricaoController.text.trim(),
                      observacao: obsController.text.trim(),
                      especialista: especialistaController.text.trim(),
                      tipoAgendamento: tipoAgendamentoController.text.trim(),
                      intervaloData: intervalo
                    );
                    bool register = await ScheduleService.getSchedule(schedule);
                    if (register) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Agendamento cadastrado com sucesso!',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (c) {
                          return ScheduleListScreen();
                        },
                      ));
                    }
                  }
                },
                child: const Text(
                  'Agendar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
