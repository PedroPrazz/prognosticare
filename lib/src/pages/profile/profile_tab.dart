import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/src/api/service/person_update_service.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/pessoa_model.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';

// ignore: must_be_immutable
class ProfileTab extends StatefulWidget {
  ProfileTab({super.key, required this.pessoa});

  Pessoa pessoa;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final phoneFormatter = MaskTextInputFormatter(
    mask: '(##)#####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  bool doadorMarcado = false;
  bool alergiaMarcada = false;

  TextEditingController Controller = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController cnsController = TextEditingController();
  TextEditingController cpsController = TextEditingController();
  TextEditingController tipoSanguineoController = TextEditingController();
  TextEditingController tipoAlergiaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.pessoa.nome;
    cpfController.text = widget.pessoa.cpf;
    emailController.text = widget.pessoa.email;
    dataController.text = widget.pessoa.dataNascimento;
    telefoneController.text = widget.pessoa.contato ?? '';
    cnsController.text = widget.pessoa.cartaoNacional ?? '';
    cpsController.text = widget.pessoa.cartaoPlanoSaude ?? '';
    tipoSanguineoController.text = widget.pessoa.tipoSanguineo ?? 'SELECIONE';
    tipoAlergiaController.text = widget.pessoa.tipoAlergia ?? '';
    alergiaMarcada = widget.pessoa.alergia ?? false;
    doadorMarcado = widget.pessoa.doador ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do Usuário',
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //Nome
          CustomTextField(
            readOnly: true,
            initialValue: widget.pessoa.nome,
            icon: Icons.person,
            label: 'Nome',
          ),
          //CPF
          CustomTextField(
            readOnly: true,
            initialValue: widget.pessoa.cpf,
            icon: Icons.file_copy,
            label: 'CPF',
          ),
          //Data de Nascimento
          CustomTextField(
            readOnly: true,
            initialValue: widget.pessoa.dataNascimento,
            icon: Icons.date_range,
            label: 'Data de Nascimento',
          ),
          //Email
          CustomTextField(
            readOnly: true,
            initialValue: widget.pessoa.email,
            icon: Icons.email,
            label: 'Email',
          ),
          //Telefone
          CustomTextField(
            controller: telefoneController,
            icon: Icons.phone,
            label: 'Telefone',
            inputFormatters: [phoneFormatter],
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
                    color: CustomColors.customSwatchColor,
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
          //É doador de orgãos
          CheckboxListTile(
            title: Text('É doador de Orgãos?'),
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: CustomColors.customSwatchColor,
            value: doadorMarcado,
            onChanged: (bool? value) {
              setState(
                () {
                  doadorMarcado = value ?? false;
                },
              );
            },
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
                Pessoa pessoaAtualizada = widget.pessoa.copyWith(
                  pessoaId: widget.pessoa.pessoaId,
                  nome: widget.pessoa.nome,
                  cpf: widget.pessoa.cpf,
                  email: widget.pessoa.email,
                  contato: telefoneController.text,
                  dataNascimento: widget.pessoa.dataNascimento,
                  tipoSanguineo: tipoSanguineoController.text,
                  tipoAlergia: tipoAlergiaController.text,
                  tipoResponsavel: widget.pessoa.tipoResponsavel,
                  cartaoNacional: cnsController.text,
                  cartaoPlanoSaude: cpsController.text,
                  alergia: alergiaMarcada,
                  doador: doadorMarcado,
                );

                if (telefoneController.text.length > 1 &&
                    telefoneController.text.length < 14) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Telefone inválido!'),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (cnsController.text.length > 1 &&
                    cnsController.text.length < 21) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cartão Nacional de Saúde inválido'),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (cpsController.text.length > 1 &&
                    cpsController.text.length < 21) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cartão do Plano de Saúde inválido'),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (alergiaMarcada =
                    true && tipoAlergiaController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Preencha o tipo de alergia ou desmarque a opção de alergia.'),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                Pessoa pessoaAtualizado =
                    await PersonUpdateService.getPerson(pessoaAtualizada);
                // ignore: unnecessary_null_comparison
                if (pessoaAtualizado != null) {
                  setState(() {
                    widget.pessoa = pessoaAtualizado;
                  });
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
                } else {
                  print("id: ${pessoaAtualizada.pessoaId}");
                  print("Nome: ${pessoaAtualizada.nome}");
                  print("CPF: ${pessoaAtualizada.cpf}");
                  print("Email: ${pessoaAtualizada.email}");
                  print("Contato: ${pessoaAtualizada.contato}");
                  print(
                      "Data de Nascimento: ${pessoaAtualizada.dataNascimento}");
                  print("tipoSanguineo: ${pessoaAtualizada.tipoSanguineo}");
                  print("alergia: ${pessoaAtualizada.alergia}");
                  print('doador:${pessoaAtualizada.doador}');
                  print("responsavel: ${pessoaAtualizada.tipoResponsavel}");
                  print("tipoAlergia: ${pessoaAtualizada.tipoAlergia}");
                  print("cartaoNacional: ${pessoaAtualizada.cartaoNacional}");
                  print(
                      "cartaoPlanoSaude: ${pessoaAtualizada.cartaoPlanoSaude}");
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
