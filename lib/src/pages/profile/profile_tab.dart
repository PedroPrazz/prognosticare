import 'package:flutter/material.dart';
import 'package:prognosticare/src/models/pessoa.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/common_widgets/custom_text_field.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key, required this.pessoa});
  
  final Pessoa pessoa;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen()), (route) => false);
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
            initialValue: widget.pessoa.contato,
            icon: Icons.phone,
            label: 'Telefone',
          ),
          //CNS
          CustomTextField(
            initialValue: widget.pessoa.cartaoNacional,
            icon: Icons.payment_outlined,
            label: 'Cartão Nacional de Saúde',
          ),
          //CPS
          CustomTextField(
            initialValue: widget.pessoa.cartaoPlanoSaude,
            icon: Icons.payment_outlined,
            label: 'Cartão do Plano de Saúde',
          ),
          //Alergia a Medicamentos
          CustomTextField(
            initialValue: widget.pessoa.tipoAlergia,
            icon: Icons.medication_outlined,
            label: 'Alergia a Medicamentos',
          ),
          //Tipo Sanguíneo
          CustomTextField(
            initialValue: widget.pessoa.tipoSanguineo,
            icon: Icons.bloodtype,
            label: 'Tipo Sanguíneo',
          ),
          //É doador de orgãos
          CustomTextField(
            icon: Icons.done,
            label: 'É doador de orgãos',
          ),
        ],
      ),
    );
  }
}
