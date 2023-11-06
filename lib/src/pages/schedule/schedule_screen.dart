// ignore_for_file: must_be_immutable, unnecessary_null_comparison, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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

  String mapTipoAgendamento(String selectedValue) {
  switch (selectedValue) {
    case 'EXAME':
      return 'Exames';
    case 'CONSULTA':
      return 'Consultas';
    case 'INTERNAÇÃO':
      return 'Internações';
    case 'VACINA':
      return 'Vacinas';
    case 'CIRURGIA':
      return 'Cirurgias';
    default:
      return 'SELECIONE';
  }
}
  String mapTipoEspecialista(String selectedValue) {
  switch (selectedValue) {
    case 'ORTOPEDIA':
      return 'Ortopedista';
    case 'CLINICO_GERAL':
      return 'Clinico Geral';
    case 'GINECOLOGIA':
      return 'Ginecologista';
    case 'DERMATOLOGIA':
      return 'Dermatologista';
    case 'NAO_POSSUI':
      return 'Não Possui';
    default:
      return 'SELECIONE';
  }
}

  List<int> intervaloData = [1, 2, 3, 5];

  int selectedValue = 1;

  // Variável para armazenar o valor selecionado na combo box
  String? tipoSelecionado;

  final dataFormatter = MaskTextInputFormatter(
    mask: '##/##/#### ##:##', // Define a máscara como 'dd/MM/yyyy HH:mm'
    filter: {"#": RegExp(r'[0-9]')}, // Define os caracteres permitidos
  );

  TextEditingController especialistaController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController localController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController obsController = TextEditingController();
  TextEditingController tipoAgendamentoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool tipoAgendamentoValido = false;
  bool especialistaValido = false;
  bool descricaoValido = false;
  bool localValido = false;
  bool datahValido = false;
  bool obsValido = false;
  bool notificacaoMarcada = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      tipoAgendamentoController.text = widget.schedule!.tipoAgendamento ?? 'SELECIONE';
      especialistaController.text = widget.schedule!.especialista ?? 'SELECIONE';
      descricaoController.text = widget.schedule!.descricao;
      localController.text = widget.schedule!.local;
      dataController.text = widget.schedule!.dataAgenda;
      notificacaoMarcada = widget.schedule!.notificacao ?? false;
      if (widget.schedule!.intervaloData != null) {
        selectedValue = widget.schedule!.intervaloData;
      }
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
              Navigator.pop(context);
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
                    'INTERNACAO',
                    'VACINA',
                    'CIRURGIA',
                  ].map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Icon(Icons.library_books,
                                color: CustomColors.customSwatchColor),
                            SizedBox(width: 10),
                            Text(
                              mapTipoAgendamento(value),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                  validator: (tipoAgendamento) {
                    if (tipoAgendamento == null ||
                        tipoAgendamento.trim().isEmpty) {
                      return 'Informe um Tipo de Agendamento!';
                    }
                    tipoAgendamentoValido = true;
                    return null;
                  },
                ),
              ),
            ),
            //Especialista
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                width: 300,
                child: DropdownButtonFormField<String>(
                  focusColor: Colors.white,
                  decoration: InputDecoration(
                    hoverColor: Colors.blue,
                    labelText: 'Especialidade',
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
                  value: especialistaController.text.isEmpty
                      ? null
                      : especialistaController.text,
                  onChanged: (String? newValue) {
                    setState(() {
                      especialistaController.text = newValue!;
                    });
                  },
                  items: <String>[
                    'ORTOPEDIA',
                    'CLINICO_GERAL',
                    'CARDIOLOGIA',
                    'GINECOLOGIA',
                    'NAO_POSSUI',
                    'DERMATOLOGIA'
                  ].map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Icon(Icons.person,
                                color: CustomColors.customSwatchColor),
                            SizedBox(width: 10),
                            Text(
                              mapTipoEspecialista(value),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                  validator: (especialista) {
                    if (especialista == null || especialista.trim().isEmpty) {
                      return 'Informe um especialista!';
                    }
                    especialistaValido = true;
                    return null;
                  },
                ),
              ),
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
                format: DateFormat("dd/MM/yyyy HH:mm:ss a"),
                controller: dataController,
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
                      ).then(
                        (selectedTime) {
                          if (selectedTime != null) {
                            final selectedDateTime = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );
                            dataController.text =
                                DateFormat("dd/MM/yyyy hh:mm:ss a")
                                    .format(selectedDateTime);
                            return selectedDateTime;
                          } else {
                            return currentValue;
                          }
                        },
                      );
                    } else {
                      return currentValue;
                    }
                  });
                },
              ),
            ),
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
            //Notificação
            CheckboxListTile(
              title: Text('Ativar notificações?'),
              controlAffinity: ListTileControlAffinity.leading,
              checkColor: CustomColors.customSwatchColor,
              value: notificacaoMarcada,
              onChanged: (bool? value) {
                setState(
                  () {
                    notificacaoMarcada = value ?? false;
                  },
                );
              },
            ),

            //Intervalo de Horas
            Visibility(
              visible: notificacaoMarcada,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  width: 300,
                  child: DropdownButtonFormField<int>(
                    focusColor: Colors.white,
                    decoration: InputDecoration(
                      hoverColor: Colors.blue,
                      labelText: 'Receba notificação com dias de antecedência',
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
                    value: selectedValue,
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedValue = newValue ?? 2;
                      });
                    },
                    items:
                        intervaloData.map<DropdownMenuItem<int>>((int value) {
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
                  if (dataController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Informe uma data e horário!',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    datahValido = true;
                  }
                  if (!tipoAgendamentoValido ||
                      !especialistaValido ||
                      !descricaoValido ||
                      !localValido ||
                      !datahValido ||
                      !obsValido) {
                    return;
                  }
                  final inputDate = dataController.text.trim();
                  final dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss a");
                  try {
                    final selectedDateTime = dateFormat.parse(inputDate);
                    final formattedDateTime =
                        DateFormat("dd/MM/yyyy hh:mm:ss a")
                            .format(selectedDateTime);
                    final intervalo = selectedValue;
                    if (widget.isEditing == true) {
                      final schedule = Schedule.editar(
                          id: widget.schedule!.id,
                          dataAgenda: formattedDateTime,
                          local: localController.text.trim(),
                          descricao: descricaoController.text.trim(),
                          observacao: obsController.text.trim(),
                          especialista: especialistaController.text.trim(),
                          tipoAgendamento:
                              tipoAgendamentoController.text.trim(),
                          notificacao: notificacaoMarcada,
                          intervaloData: intervalo);
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScheduleListScreen()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Erro no servidor, tente depois',
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
                          tipoAgendamento:
                              tipoAgendamentoController.text.trim(),
                          notificacao: notificacaoMarcada,
                          intervaloData: intervalo);
                      bool register =
                          await ScheduleService.getSchedule(schedule);
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
                  } catch (e) {
                    print("Erro ao analisar a data e hora: $e");
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
