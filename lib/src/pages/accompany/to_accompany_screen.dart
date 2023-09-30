import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/src/api/service/to_accompany_register_service.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';
import 'package:prognosticare/src/pages/accompany/to_accompany_list_screen.dart';

class ToAccompanyScreen extends StatefulWidget {
  final Accompany? accompany;

  ToAccompanyScreen({Key? key, this.accompany}) : super(key: key);

  @override
  State<ToAccompanyScreen> createState() => _ToAccompanyScreenState();
}

class _ToAccompanyScreenState extends State<ToAccompanyScreen> {
  // Lista de tipos de agendamentos
  List<String> tipoDeAcompanhamento = ['Medicacao', 'Procedimentos'];

  // Variável para armazenar o valor selecionado na combo box
  String? tipoSelecionado;

  final dataFormatter = MaskTextInputFormatter(
    mask: '##/##/#### ##:##', // Define a máscara como 'dd/MM/yyyy HH:mm'
    filter: {"#": RegExp(r'[0-9]')}, // Define os caracteres permitidos
  );

  TextEditingController tipoAcompanhamentoController = TextEditingController();
  TextEditingController medicacaoController = TextEditingController();
  TextEditingController dataAcompanhamentoController = TextEditingController();
  TextEditingController tipoTemporarioControladoController =
      TextEditingController();
  TextEditingController prescricaoMedicaController = TextEditingController();

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
                value: tipoAcompanhamentoController.text.isEmpty
                    ? null
                    : tipoAcompanhamentoController.text,
                onChanged: (String? newValue) {
                  setState(() {
                    tipoAcompanhamentoController.text = newValue!;
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
          //Medicação
          CustomTextField(
            controller: medicacaoController,
            icon: Icons.medical_information,
            label: 'Medicação',
          ),
          //Data e Horário
          CustomTextField(
            controller: dataAcompanhamentoController,
            icon: Icons.date_range,
            label: 'Data | Horário',
            inputFormatters: [dataFormatter],
          ),
          //Controlado ou Temporario
          CustomTextField(
            controller: tipoTemporarioControladoController,
            icon: Icons.content_paste_search_outlined,
            label: 'Controlada ou Temporária',
          ),
          CustomTextField(
            controller: prescricaoMedicaController,
            icon: Icons.medical_information_outlined,
            label: 'Prescrição Médica',
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

                bool accompany = await AccompanyService.getAccompany(
                    dataFormatada,
                    medicacaoController.text,
                    prescricaoMedicaController.text,
                    tipoTemporarioControladoController.text,
                    tipoAcompanhamentoController.text);
                if (accompany) {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (c) {
                    return ToAccompanyListScreen();
                  }));
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
