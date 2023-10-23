import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/src/api/service/accompany_service.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';
import 'package:prognosticare/src/pages/accompany/to_accompany_list_screen.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';

class ToAccompanyScreen extends StatefulWidget {
  final Accompany? accompany;
  final bool isEditing;

  ToAccompanyScreen({Key? key, this.accompany, this.isEditing = false})
      : super(key: key);
  @override
  State<ToAccompanyScreen> createState() => _ToAccompanyScreenState();
}

class _ToAccompanyScreenState extends State<ToAccompanyScreen> {
  List<String> tipoDeAcompanhamento = ['MEDICACAO', 'PROCEDIMENTO'];
  List<String> tipoDeMedicacao = ['CONTROLADO', 'TEMPORARIO'];
  List<int> intervaloHora = [0, 4, 6, 12, 24];
  int selectedValue = 0;

  final dataFormatter = MaskTextInputFormatter(
    mask: '##/##/#### ##:##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final _formKey = GlobalKey<FormState>();

  TextEditingController tipoAcompanhamentoController = TextEditingController();
  TextEditingController medicacaoController = TextEditingController();
  TextEditingController dataAcompanhamentoController = TextEditingController();
  TextEditingController tipoTemporarioControladoController =
      TextEditingController();
  TextEditingController prescricaoMedicaController = TextEditingController();

  bool tipoAcompanhamentoValido = false;
  bool medicacaoValido = false;
  bool datahValido = false;
  bool controTempValido = false;
  bool prescricaoValido = false;
  bool notificacaoMarcada = false;
  String? valorInicial;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      tipoAcompanhamentoController.text = widget.accompany!.tipoAcompanhamento;
      medicacaoController.text = widget.accompany!.medicacao;
      dataAcompanhamentoController.text = widget.accompany!.dataAcompanhamento;
      notificacaoMarcada = widget.accompany!.notificacao ?? false;
      tipoTemporarioControladoController.text = widget.isEditing
          ? widget.accompany!.tipoTemporarioControlado
          : tipoDeMedicacao[0];
      prescricaoMedicaController.text = widget.accompany!.prescricaoMedica;
      if (widget.accompany!.intervaloHora != null) {
        selectedValue = widget.accompany!.intervaloHora;
      }
    }
    valorInicial =
        tipoDeAcompanhamento.contains(tipoAcompanhamentoController.text)
            ? tipoAcompanhamentoController.text
            : null;
  }

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
            // Tipo de Acompanhamento
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
                  value: tipoAcompanhamentoController.text.trim().isEmpty
                      ? null
                      : tipoAcompanhamentoController.text.trim(),
                  onChanged: (String? newValue) {
                    setState(() {
                      tipoAcompanhamentoController.text = newValue!;
                    });
                  },
                  items: tipoDeAcompanhamento
                      .map<DropdownMenuItem<String>>((String value) {
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
                  validator: (tipoAcompanhamento) {
                    if (tipoAcompanhamento == null ||
                        tipoAcompanhamento.trim().isEmpty) {
                      return 'Informe um Tipo de Acompanhamento!';
                    }
                    tipoAcompanhamentoValido = true;
                    return null;
                  },
                ),
              ),
            ),
            //Medicação
            CustomTextField(
              controller: medicacaoController,
              icon: Icons.medical_information,
              label: 'Medicação',
              validator: (medicacao) {
                if (medicacao == null || medicacao.trim().isEmpty) {
                  return 'Informe uma medicação!';
                }
                if (medicacao.trim().length < 3) {
                  return 'Medicação deve ter no mínimo 3 caracteres!';
                }
                medicacaoValido = true;
                return null;
              },
            ),
            //Data de Acompanhamento
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: DateTimeField(
                format: DateFormat("dd/MM/yyyy HH:mm:ss a"),
                controller: dataAcompanhamentoController,
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

                          dataAcompanhamentoController.text =
                              DateFormat("dd/MM/yyyy hh:mm:ss a")
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
                // validator: (dateTime) {
                //   if (dateTime == null) {
                //     return 'Informe uma data e horário!';
                //   }
                //   datahValido = true;
                //   return null;
                // },
              ),
            ),
            // Tipo de Medicação
            CustomRadioButton(
              unSelectedColor: Colors.white,
              autoWidth: true,
              buttonLables: [
                "CONTROLADO",
                "TEMPORARIO",
              ],
              buttonValues: [
                "CONTROLADO",
                "TEMPORARIO",
              ],
              radioButtonValue: (value) {
                setState(() {
                  tipoTemporarioControladoController.text = value;
                });
              },
              selectedColor: CustomColors.customSwatchColor,
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
                    items:
                        intervaloHora.map<DropdownMenuItem<int>>((int value) {
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
            //Prescrição
            CustomTextField(
              controller: prescricaoMedicaController,
              icon: Icons.medical_information_outlined,
              label: 'Prescrição Médica',
              validator: (prescricao) {
                if (prescricao == null || prescricao.trim().isEmpty) {
                  return 'Informe uma prescrição médica!';
                }
                if (prescricao.trim().length < 3) {
                  return 'Prescrição médica deve ter no mínimo 3 caracteres!';
                }
                prescricaoValido = true;
                return null;
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
                  if (_formKey.currentState!.validate()) {
                    print('Todos os campos estão válidos');
                  } else {
                    print('Campos não válidos');
                  }
                  if (dataAcompanhamentoController.text.isEmpty) {
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
                  if (tipoTemporarioControladoController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Informe Controlado ou Temporário!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  } else {
                    controTempValido = true;
                  }
                  if (!tipoAcompanhamentoValido ||
                      !medicacaoValido ||
                      !datahValido ||
                      !controTempValido ||
                      !prescricaoValido) {
                    return;
                  }
                  final inputDate = dataAcompanhamentoController.text.trim();
                  final dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss a");
                  try {
                    final selectedDateTime = dateFormat.parse(inputDate);
                    final formattedDateTime =
                        DateFormat("dd/MM/yyyy hh:mm:ss a")
                            .format(selectedDateTime);
                    final intervalo = selectedValue;
                    if (widget.isEditing == true) {
                      final accompany = Accompany.editar(
                          id: widget.accompany!.id,
                          tipoAcompanhamento:
                              tipoAcompanhamentoController.text.trim(),
                          medicacao: medicacaoController.text.trim(),
                          dataAcompanhamento: formattedDateTime.trim(),
                          tipoTemporarioControlado:
                              tipoTemporarioControladoController.text.trim(),
                          notificacao: notificacaoMarcada,
                          prescricaoMedica:
                              prescricaoMedicaController.text.trim(),
                          intervaloHora: intervalo);
                      bool update =
                          await AccompanyService.updateAccompany(accompany);
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
                              'Erro no servidor, tente depois',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      final accompany = Accompany.criar(
                          tipoAcompanhamento:
                              tipoAcompanhamentoController.text.trim(),
                          medicacao: medicacaoController.text.trim(),
                          dataAcompanhamento: formattedDateTime.trim(),
                          tipoTemporarioControlado:
                              tipoTemporarioControladoController.text.trim(),
                          notificacao: notificacaoMarcada,
                          prescricaoMedica:
                              prescricaoMedicaController.text.trim(),
                          intervaloHora: intervalo);
                      bool register =
                          await AccompanyService.getAccompany(accompany);
                      if (register) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Acompanhamento cadastrado com sucesso!',
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
                  } catch (e) {
                    print("Erro ao analisar a data e hora: $e");
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
      ),
    );
  }
}
