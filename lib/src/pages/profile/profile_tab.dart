import 'package:flutter/material.dart';
import 'package:prognosticare/src/pages/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/config/app_data.dart' as appData;

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

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
            onPressed: () {},
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
            initialValue: appData.pessoa.nome,
            icon: Icons.person,
            label: 'Nome',
          ),
          //CPF
          CustomTextField(
            readOnly: true,
            initialValue: appData.pessoa.cpf,
            icon: Icons.file_copy,
            label: 'CPF',
          ),
          //Data de Nascimento
          CustomTextField(
            readOnly: true,
            initialValue: appData.pessoa.dataNascimento,
            icon: Icons.date_range,
            label: 'Data de Nascimento',
          ),
          //Email
          CustomTextField(
            readOnly: true,
            initialValue: appData.pessoa.email,
            icon: Icons.email,
            label: 'Email',
          ),
          //Telefone
          CustomTextField(
            initialValue: appData.pessoa.contato,
            icon: Icons.phone,
            label: 'Telefone',
          ),
          //CNS
          CustomTextField(
            initialValue: appData.pessoa.cartaoNacional,
            icon: Icons.payment_outlined,
            label: 'Cartão Nacional de Saúde',
          ),
          //CPS
          CustomTextField(
            initialValue: appData.pessoa.cartaoPlanoSaude,
            icon: Icons.payment_outlined,
            label: 'Cartão do Plano de Saúde',
          ),
          //Alergia a Medicamentos
          CustomTextField(
            initialValue: appData.pessoa.tipoAlergia,
            icon: Icons.medication_outlined,
            label: 'Alergia a Medicamentos',
          ),
          //Tipo Sanguíneo
          CustomTextField(
            initialValue: appData.pessoa.tipoSanguineo,
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
