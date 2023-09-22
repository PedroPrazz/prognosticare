import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/src/api/service/schedule_register_service.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/pages/schedule/agendamentos.dart';

class ToAccompanyScreen extends StatefulWidget {
  ToAccompanyScreen({super.key});

  @override
  State<ToAccompanyScreen> createState() => _ToAccompanyScreenState();
}

class _ToAccompanyScreenState extends State<ToAccompanyScreen> {
  // Lista de tipos de agendamentos
  List<String> tipoDeAcompanhamento = [
    'MEDICAO',
    'PROCEDIMENTO',
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
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Acompanhamentos',
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
                  labelText: 'Tipo de Acompanhamento',
                  labelStyle: TextStyle(color: Colors.black),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(255, 143, 171, 1),
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
                  'MEDICACAO',
                  'PROCEDIMENTO',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(Icons.library_books,
                            color: Color.fromRGBO(255, 143, 171, 1)),
                        SizedBox(width: 10),
                        Text(
                          value,
                          style: TextStyle(
                            color: Color.fromRGBO(255, 143, 171, 1),
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
            label: 'Prescrição Médica',
          ),
          //Descrição
          CustomTextField(
            controller: descricaoController,
            icon: Icons.description,
            label: 'Medicação',
          ),
          //Local
          CustomTextField(
            controller: localController,
            icon: Icons.location_on,
            label: 'Controloda ou Temporária',
          ),
          //Data e Horário
          CustomTextField(
            controller: datahController,
            icon: Icons.date_range,
            label: 'Agendamento | Horário',
            inputFormatters: [dataFormatter],
          ),
          //Observações
          CustomTextField(
            controller: obsController,
            icon: Icons.description,
            label: 'Observações',
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
                final dataFormatada =
                    DateFormat('dd/MM/yyyy hh:mm:ss a').format(DateTime.now());
                    
                bool schedule = await ScheduleService.getSchedule(
                    dataFormatada,
                    localController.text,
                    descricaoController.text,
                    obsController.text,
                    especialistaController.text,
                    tipoAgendamentoController.text);
                if (schedule) {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (c) {
                    return Agendamentos();
                  }));
                }
              },
              child: const Text(
                'Salvar',
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
