// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/src/api/service/dependent_service.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/dependent_model.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/pages/auth/dependents.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';

class ProfileTabDepentende extends StatefulWidget {
  final Dependente? dependente;
  bool isEditing;

  ProfileTabDepentende({Key? key, this.dependente, this.isEditing = false})
      : super(key: key);

  @override
  State<ProfileTabDepentende> createState() => _ProfileTabDepentendeState();
}

class _ProfileTabDepentendeState extends State<ProfileTabDepentende> {
  final cpfFormartter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final dataFormartter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  String mapTipoSanguineo(String selectedValue) {
    switch (selectedValue) {
      case 'A_POSITIVO':
        return 'A+';
      case 'A_NEGATIVO':
        return 'A-';
      case 'B_POSITIVO':
        return 'B+';
      case 'B_NEGATIVO':
        return 'B-';
      case 'O_POSITIVO':
        return 'O+';
      case 'O_NEGATIVO':
        return 'O-';
      case 'AB_POSITIVO':
        return 'AB+';
      case 'AB_NEGATIVO':
        return 'AB-';
      default:
        return 'SELECIONE';
    }
  }

  bool nomeValido = false;
  bool cpfValido = false;
  bool dataValida = false;
  bool cnsValido = false;
  bool cpsValido = false;
  bool tipoSanguineoValido = false;
  bool alergiaMarcada = false;
  bool tipoAlergiaValido = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController cnsController = TextEditingController();
  TextEditingController cpsController = TextEditingController();
  TextEditingController tipoSanguineoController = TextEditingController();
  TextEditingController tipoAlergiaController = TextEditingController();
  TextEditingController alergiaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      nomeController.text = widget.dependente!.nome;
      cpfController.text = widget.dependente!.cpf;
      if (widget.dependente!.dataNascimento != null) {
        final formattedDate = DateFormat('dd/MM/yyyy')
            .format(DateTime.parse(widget.dependente!.dataNascimento));
        dataController.text = formattedDate;
      }
      cnsController.text = widget.dependente!.cartaoNacional ?? '';
      cpsController.text = widget.dependente!.cartaoPlanoSaude ?? '';
      tipoSanguineoController.text =
          widget.dependente!.tipoSanguineo ?? 'SELECIONE';
      alergiaMarcada = widget.dependente!.alergia ?? false;
      tipoAlergiaController.text = widget.dependente!.tipoAlergia ?? '';
      alergiaController.text = widget.dependente!.alergia.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isEditing ? 'Editar Dependente' : 'Adicionar Dependente',
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
        body: Container(
            child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            children: [
              //Nome
              CustomTextField(
                controller: nomeController,
                icon: Icons.person,
                label: 'Nome',
                validator: (nome) {
                  if (nome == null || nome.trim().isEmpty) {
                    return 'Digite o nome completo!';
                  }
                  if (nome.trim().length < 3) {
                    return 'Nome deve ter no mínimo 3 caracteres!';
                  }
                  nomeValido = true;
                  return null;
                },
              ),
              //CPF
              CustomTextField(
                controller: cpfController,
                icon: Icons.file_copy,
                inputFormatters: [cpfFormartter],
                label: 'CPF',
                validator: (cpf) {
                  if (cpf == null || cpf.trim().isEmpty) {
                    return 'Digite o CPF!';
                  }
                  if (GetUtils.isCpf(cpf.trim())) {
                    print('CPF Válido');
                  } else {
                    return 'CPF Inválido';
                  }
                  cpfValido = true;
                  return null;
                },
              ),
              //Data de Nascimento
              CustomTextField(
                controller: dataController,
                icon: Icons.date_range,
                inputFormatters: [dataFormartter],
                label: 'Data de Nascimento',
                validator: (data) {
                  if (data == null || data.trim().isEmpty) {
                    return 'Digite a Data de Nascimento!';
                  }
                  DateTime dataNascimento;
                  try {
                    dataNascimento =
                        DateFormat('dd/MM/yyyy').parse(data.trim());
                  } catch (e) {
                    return 'Data de Nascimento inválida.';
                  }
                  DateTime dataAtual = DateTime.now();
                  // Verifique se a data de nascimento é posterior à data atual
                  if (dataNascimento.isAfter(dataAtual)) {
                    return 'A Data de Nascimento não pode ser no futuro.';
                  }
                  dataValida = true;
                  return null;
                },
              ),

              //CNS
              CustomTextField(
                controller: cnsController,
                icon: Icons.payment_outlined,
                label: 'Cartão Nacional de Saúde',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CNSInputFormatter()
                ],
                validator: (cns) {
                  if (cns == null || cns.isEmpty) {
                    return 'Digite seu Cartão Nacional de Saúde!';
                  }
                  if (cnsController.text.trim().length > 0 &&
                      cnsController.text.trim().length < 18) {
                    return 'Cartão Nacional de Saúde inválido!';
                  }
                  cnsValido = true;
                  return null;
                },
              ),
              //CPS
              CustomTextField(
                controller: cpsController,
                icon: Icons.payment_outlined,
                label: 'Cartão do Plano de Saúde',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CNSInputFormatter()
                ],
                validator: (cps) {
                  if (cps == null || cps.isEmpty) {
                    return 'Digite seu Cartão Nacional de Saúde!';
                  }
                  if (cpsController.text.trim().length > 0 &&
                      cpsController.text.trim().length < 18) {
                    return 'Cartão do Plano de Saúde inválido!';
                  }
                  cpsValido = true;
                  return null;
                },
              ),
              //Tipo Sanguíneo
              Container(
                width: 300,
                child: DropdownButtonFormField<String>(
                  focusColor: Colors.white,
                  decoration: InputDecoration(
                    hoverColor: Colors.blue,
                    labelText: 'Tipo Sanguíneo',
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
                  value: tipoSanguineoController.text.trim().isEmpty
                      ? null
                      : tipoSanguineoController.text.trim(),
                  onChanged: (String? newValue) {
                    setState(() {
                      tipoSanguineoController.text = newValue!;
                    });
                  },
                  items: <String>[
                    'A_POSITIVO',
                    'A_NEGATIVO',
                    'B_POSITIVO',
                    'B_NEGATIVO',
                    'O_POSITIVO',
                    'O_NEGATIVO',
                    'AB_POSITIVO',
                    'AB_NEGATIVO',
                    'SELECIONE'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(Icons.bloodtype,
                              color: CustomColors.customSwatchColor),
                          SizedBox(width: 10),
                          Text(
                            mapTipoSanguineo(value),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  validator: (tipoSanguineo) {
                    if (tipoSanguineo == null || tipoSanguineo.trim().isEmpty) {
                      return 'Informe um Tipo Sanguineo!';
                    }
                    tipoSanguineoValido = true;
                    return null;
                  },
                ),
              ),
              //Alergia a Medicamentos
              CheckboxListTile(
                title: Text('Alergia a Medicamentos?'),
                controlAffinity: ListTileControlAffinity.leading,
                checkColor: CustomColors.customSwatchColor,
                value: alergiaMarcada,
                onChanged: (bool? value) {
                  setState(
                    () {
                      alergiaMarcada = value ?? false;
                    },
                  );
                },
              ),
              Visibility(
                visible: alergiaMarcada,
                child: CustomTextField(
                  controller: tipoAlergiaController,
                  icon: Icons.medication,
                  label: 'Tipo de Alergia',
                  validator: (tipoAlergia) {
                    if (tipoAlergiaController.text.trim().isEmpty) {
                      return 'Digite o tipo de alergia ou desmarque o campo de alergia!';
                    }
                    if (tipoAlergiaController.text.trim().length > 0 &&
                        tipoAlergiaController.text.trim().length < 3) {
                      return 'Tipo de alergia inválido!';
                    }
                    tipoAlergiaValido = true;
                    return null;
                  },
                ),
              ),
              // Botão de Cadastrar
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
                    if (!nomeValido ||
                        !cpfValido ||
                        !dataValida ||
                        !cnsValido ||
                        !cpsValido ||
                        !tipoSanguineoValido ||
                        (alergiaMarcada && !tipoAlergiaValido)) {
                      return;
                    }
                    if (widget.isEditing == true) {
                      final dependente = Dependente.editar(
                        ativo: widget.dependente!.ativo,
                        pessoaId: widget.dependente!.pessoaId,
                        nome: nomeController.text.trim(),
                        cpf: cpfController.text.trim(),
                        dataNascimento: dataController.text.trim(),
                        tipoSanguineo: tipoSanguineoController.text.trim(),
                        alergia: alergiaMarcada,
                        tipoAlergia: tipoAlergiaController.text.trim(),
                        cartaoNacional: cnsController.text.trim(),
                        cartaoPlanoSaude: cpsController.text.trim(),
                      );
                      bool update =
                          await DependentService.updateDependent(dependente);
                      if (update) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Dependente atualizado com sucesso!',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (c) {
                            return ListDependents();
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
                      final dependente = Dependente.cadastrar(
                        nome: nomeController.text.trim(),
                        cpf: cpfController.text.trim(),
                        dataNascimento: dataController.text.trim(),
                        tipoSanguineo: tipoSanguineoController.text.trim(),
                        alergia: alergiaMarcada,
                        tipoAlergia: tipoAlergiaController.text.trim(),
                        cartaoNacional: cnsController.text.trim(),
                        cartaoPlanoSaude: cpsController.text.trim(),
                      );
                      bool register =
                          await DependentService.getRegisterD(dependente);
                      if (register) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Dependente cadastrado com sucesso!',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (c) {
                            return ListDependents();
                          },
                        ));
                      }
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
        )));
  }
}
