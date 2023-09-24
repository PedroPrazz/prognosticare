import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/src/api/service/dependent_register_service.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
<<<<<<< HEAD
import 'package:prognosticare/src/models/dependente.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
=======
import 'package:prognosticare/src/models/dependent_model.dart';
>>>>>>> 348acbd8b6dbff923c2aa92fc29e969bf467b912
import 'package:prognosticare/src/pages/home/home_screen.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';

class ProfileTabDependente extends StatefulWidget {
  ProfileTabDependente({super.key, required this.dependente});

  Dependente dependente;

  @override
  State<ProfileTabDependente> createState() => _ProfileTabDependenteState();
}
<<<<<<< HEAD

class _ProfileTabDependenteState extends State<ProfileTabDependente> {
=======

class _ProfileTabDepentendeState extends State<ProfileTabDepentende> {

  final cpfFormartter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final dataFormartter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );

>>>>>>> 348acbd8b6dbff923c2aa92fc29e969bf467b912
  bool doadorMarcado = false;
  bool alergiaMarcada = false;

  TextEditingController nomeController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController cnsController = TextEditingController();
  TextEditingController cpsController = TextEditingController();
  TextEditingController tipoSanguineoController = TextEditingController();
  TextEditingController tipoAlergiaController = TextEditingController();
  TextEditingController alergiaController = TextEditingController();

<<<<<<< HEAD
  @override
  void initState() {
    super.initState();
    nomeController.text = widget.dependente.nome;
    cpfController.text = widget.dependente.cpf;
    dataController.text = widget.dependente.dataNascimento;
    cnsController.text = widget.dependente.cartaoNacional ?? '';
    cpsController.text = widget.dependente.cartaoPlanoSaude ?? '';
    tipoSanguineoController.text =
        widget.dependente.tipoSanguineo ?? 'SELECIONE';
    alergiaMarcada = widget.dependente.alergia ?? false;
    tipoAlergiaController.text = widget.dependente.tipoAlergia ?? '';
    doadorMarcado = widget.dependente.doador ?? false;
    alergiaController.text = widget.dependente.alergia.toString();
    // doadorController.text = widget.dependente.doador.toString();
  }
=======
  // @override
  // void initState() {
  //   super.initState();
  //   nomeController.text = widget.pessoa.nome;
  //   cpfController.text = widget.pessoa.cpf;
  //   dataController.text = widget.pessoa.dataNascimento;
  //   cnsController.text = widget.pessoa.cartaoNacional ?? '';
  //   cpsController.text = widget.pessoa.cartaoPlanoSaude ?? '';
  //   tipoSanguineoController.text = widget.pessoa.tipoSanguineo ?? 'SELECIONE';
  //   alergiaMarcada = widget.pessoa.alergia ?? false;
  //   tipoAlergiaController.text = widget.pessoa.tipoAlergia ?? '';
  //   alergiaController.text = widget.pessoa.alergia.toString();
  // }
>>>>>>> 348acbd8b6dbff923c2aa92fc29e969bf467b912

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do Dependente',
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //Nome
          CustomTextField(
            controller: nomeController,
            icon: Icons.person,
            label: 'Nome',
          ),
          //CPF
          CustomTextField(
            controller: cpfController,
            icon: Icons.file_copy,
            inputFormatters: [cpfFormartter],
            label: 'CPF',
          ),
          //Data de Nascimento
          CustomTextField(
            controller: dataController,
            icon: Icons.date_range,
            inputFormatters: [dataFormartter],
            label: 'Data de Nascimento',
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
                    color: Color.fromRGBO(255, 143, 171, 1),
                  ),
                ),
              ),
              value: tipoSanguineoController.text.isEmpty
                  ? null
                  : tipoSanguineoController.text,
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
                bool saveDependent = await RegisterServiceDepents.getRegisterD(
                  Dependente(
                    nome: nomeController.text,
                    cpf: cpfController.text,
                    dataNascimento: dataController.text,
                    tipoSanguineo: tipoSanguineoController.text,
                    alergia: alergiaMarcada,
                    tipoAlergia: tipoAlergiaController.text,
                    cartaoNacional: cnsController.text,
                    cartaoPlanoSaude: cpsController.text,
                  ),
                );
                if (saveDependent) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (c) {
                        return HomeScreen();
                      },
                    ),
                  );
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
