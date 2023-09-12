import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/personUpdateService.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/pessoa.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/base/base_screen.dart';
import 'package:prognosticare/src/pages/common_widgets/custom_text_field.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key, required this.pessoa});

  final Pessoa pessoa;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool doadorMarcado = false;
  bool alergiaMarcada = false;


  final Controller = TextEditingController();
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final dataController = TextEditingController();
  final telefoneController = TextEditingController();
  final cnsController = TextEditingController();
  final cpsController = TextEditingController();
  final tipoSanguineoController = TextEditingController();
  final tipoAlergiaController = TextEditingController();

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
            // controller: telefoneController,
            initialValue: widget.pessoa.contato,
            icon: Icons.phone,
            label: 'Telefone',
          ),
          //CNS
          CustomTextField(
            // controller: cnsController,
            initialValue: widget.pessoa.cartaoNacional,
            icon: Icons.payment_outlined,
            label: 'Cartão Nacional de Saúde',
          ),
          //CPS
          CustomTextField(
            // controller: cpsController,
            initialValue: widget.pessoa.cartaoPlanoSaude,
            icon: Icons.payment_outlined,
            label: 'Cartão do Plano de Saúde',
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
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Tipo sanguíneo is required';
              //   }
              //   return null;
              // },
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
                  alergiaMarcada = value!;
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
                  doadorMarcado = value!;
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
                  nome: nomeController.text,
                  cpf: cpfController.text,
                  contato: telefoneController.text,
                  dataNascimento: dataController.text,
                  tipoSanguineo: tipoSanguineoController.text,
                  alergia: alergiaMarcada,
                  doador: doadorMarcado,
                  tipoAlergia: tipoAlergiaController.text,
                  tipoResponsavel: widget.pessoa.tipoResponsavel,
                  cartaoNacional: cnsController.text,
                  cartaoPlanoSaude: cpsController.text,
                );
                bool update =
                    await PersonUpdateService.getPerson(pessoaAtualizada);
                if (update) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BaseScreen()));
                } else {
                  print("id: ${pessoaAtualizada.pessoaId}");
                  print("Nome: ${pessoaAtualizada.nome}");
                  print("CPF: ${pessoaAtualizada.cpf}");
                  print("Contato: ${pessoaAtualizada.contato}");
                  print("Data de Nascimento: ${pessoaAtualizada.dataNascimento}");
                  print("tipoSanguineo: ${pessoaAtualizada.tipoSanguineo}");
                  print("alergia: ${pessoaAtualizada.alergia}");
                  print('doador:${pessoaAtualizada.doador}');
                  print("responsavel: ${pessoaAtualizada.tipoResponsavel}");
                  print("tipoAlergia: ${pessoaAtualizada.tipoAlergia}");
                  print("cartaoNacional: ${pessoaAtualizada.cartaoNacional}");
                  print("cartaoPlanoSaude: ${pessoaAtualizada.cartaoPlanoSaude}");
                }
              },
              child: const Text(
                'Cadastrar',
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
