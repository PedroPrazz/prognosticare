// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/src/api/service/to_accompany_list_service.dart';
import 'package:prognosticare/src/api/service/to_accompany_register_service.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';
import 'package:prognosticare/src/pages/accompany/to_accompany_list_screen.dart';

class ToAccompanyScreen extends StatefulWidget {
  final Accompany? accompany;
  bool isEditing;

  ToAccompanyScreen({Key? key, this.accompany, this.isEditing = false})
      : super(key: key);

  @override
  State<ToAccompanyScreen> createState() => _ToAccompanyScreenState();
}

class _ToAccompanyScreenState extends State<ToAccompanyScreen> {
  // Lista de tipos de agendamentos
  List<String> tipoDeAcompanhamento = ['Medicacao', 'Procedimentos'];
  List<int> intervaloHora = [2, 3, 4, 6, 8, 12];

  int selectedValue = 2;

  // Variável para armazenar o valor selecionado na combo box
  String? tipoSelecionado;

  final dataFormatter = MaskTextInputFormatter(
    mask: '##/##/#### ##:##', // Define a máscara como 'dd/MM/yyyy HH:mm'
    filter: {"#": RegExp(r'[0-9]')}, // Define os caracteres permitidos
  );

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      tipoAcompanhamentoController.text = widget.accompany!.tipoAcompanhamento;
      medicacaoController.text = widget.accompany!.medicacao;
      dataAcompanhamentoController.text = widget.accompany!.dataAcompanhamento;
      tipoTemporarioControladoController.text =
          widget.accompany!.tipoTemporarioControlado;
      prescricaoMedicaController.text = widget.accompany!.prescricaoMedica;
    }
  }

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
        title: Text(
          widget.isEditing
              ? 'Editar Acompanhamento'
              : 'Adicionar Acompanhamento',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        foregroundColor: Colors.white,
        backgroundColor: CustomColors.customSwatchColor,
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
                      color: CustomColors.customSwatchColor,
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

          //Intervalo de horas
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
                value: selectedValue,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedValue = newValue ?? 2;
                  });
                },
                items: intervaloHora.map<DropdownMenuItem<int>>((int value) {
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
          //Prescrição
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
                if (widget.isEditing == true) {
                  final accompany = Accompany.editar(
                    id: widget.accompany!.id,
                    tipoAcompanhamento: tipoAcompanhamentoController.text,
                    medicacao: medicacaoController.text,
                    dataAcompanhamento: dataAcompanhamentoController.text,
                    tipoTemporarioControlado: tipoTemporarioControladoController.text,
                    prescricaoMedica: prescricaoMedicaController.text,
                  );
                  bool update =
                      await ToAccompanyListService.updateAccompany(accompany);
                  if (update) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Acompanhamento atualizado com sucesso!',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (c) {
                        return ToAccompanyListScreen();
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
                  final accompany = Accompany.criar(
                    tipoAcompanhamento: tipoAcompanhamentoController.text,
                    medicacao: medicacaoController.text,
                    dataAcompanhamento: dataAcompanhamentoController.text,
                    tipoTemporarioControlado:
                        tipoTemporarioControladoController.text,
                    prescricaoMedica: prescricaoMedicaController.text,
                  );
                  bool register =
                      await AccompanyService.getAccompany(accompany);
                  if (register) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Agendamento cadastrado com sucesso!',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (c) {
                          return ToAccompanyListScreen();
                        },
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Acompanhar',
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
