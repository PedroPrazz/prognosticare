import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/src/api/service/schedule_list_service.dart';
import 'package:prognosticare/src/api/service/schedule_register_service.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/schedule_model.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/pages/schedule/schedule_list_screen.dart';

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
  bool realizado = false;

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
      realizado = widget.schedule!.realizado ?? false;
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
      ),
      body: ListView(
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
          ),
          //Descrição
          CustomTextField(
            controller: descricaoController,
            icon: Icons.description,
            label: 'Descrição',
          ),
          //Local
          CustomTextField(
            controller: localController,
            icon: Icons.location_on,
            label: 'Local',
          ),
          //Data e Horário
          CustomTextField(
            controller: datahController,
            icon: Icons.date_range,
            label: 'Data | Horário',
            inputFormatters: [dataFormatter],
          ),

          //Observações
          CustomTextField(
            controller: obsController,
            icon: Icons.description,
            label: 'Observações',
          ),
          //Realização do agendamento
          CheckboxListTile(
            title: Text('Foi realizado?'),
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: CustomColors.customSwatchColor,
            value: realizado,
            onChanged: (bool? value) {
              setState(
                () {
                  realizado = value ?? false;
                },
              );
            },
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
                if (widget.isEditing == true) {
                  final schedule = Schedule.editar(
                    id: widget.schedule!.id,
                    dataAgenda: datahController.text,
                    local: localController.text,
                    descricao: descricaoController.text,
                    observacao: obsController.text,
                    especialista: especialistaController.text,
                    tipoAgendamento: tipoAgendamentoController.text,
                  );
                  bool update =
                      await ScheduleListService.updateSchedule(schedule);
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
                    dataAgenda: datahController.text,
                    local: localController.text,
                    descricao: descricaoController.text,
                    observacao: obsController.text,
                    especialista: especialistaController.text,
                    tipoAgendamento: tipoAgendamentoController.text,
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
    );
  }
}
