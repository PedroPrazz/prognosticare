import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/src/api/service/person_update_service.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/pessoa_model.dart';
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

  bool telefoneValido = false;
  bool cnsValido = false;
  bool cpsValido = false;
  bool doadorMarcado = false;
  bool alergiaMarcada = false;
  bool tipoSanguineoValido = false;
  bool tipoAlergiaValido = false;

  final _formKey = GlobalKey<FormState>();

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
    nomeController.text = widget.pessoa.nome!;
    cpfController.text = widget.pessoa.cpf!;
    emailController.text = widget.pessoa.email ?? '';
    dataController.text = widget.pessoa.dataNascimento!;
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
                validator: (telefone) {
                  // if (telefone == null || telefone.isEmpty) {
                  //   return 'Informe seu telefone!';
                  // }
                  if (telefoneController.text.trim().length > 0 &&
                      telefoneController.text.trim().length < 14) {
                    return 'Telefone inválido!';
                  }
                  telefoneValido = true;
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
                  // if (cns == null || cns.isEmpty) {
                  //   return 'Informe seu Cartão Nacional de Saúde!';
                  // }
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
                  // if (cps == null || cps.isEmpty) {
                  //   return 'Informe seu Cartão Nacional de Saúde!';
                  // }
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
                            value,
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
                      return 'Informe o tipo de alergia ou desmarque o campo de alergia!';
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
                    if (_formKey.currentState!.validate()) {
                      print('Todos os campos estão válidos');
                    } else {
                      print('Campos não válidos');
                    }
                    if (!telefoneValido ||
                        !cnsValido ||
                        !cpsValido ||
                        !tipoSanguineoValido ||
                        (alergiaMarcada && !tipoAlergiaValido)) {
                      return;
                    }
                    Pessoa pessoaAtualizada = widget.pessoa.copyWith(
                      pessoaId: widget.pessoa.pessoaId?.trim(),
                      nome: widget.pessoa.nome?.trim(),
                      cpf: widget.pessoa.cpf?.trim(),
                      email: widget.pessoa.email?.trim(),
                      contato: telefoneController.text.trim(),
                      dataNascimento: widget.pessoa.dataNascimento?.trim(),
                      tipoSanguineo: tipoSanguineoController.text.trim(),
                      tipoAlergia: tipoAlergiaController.text.trim(),
                      tipoResponsavel: widget.pessoa.tipoResponsavel,
                      cartaoNacional: cnsController.text.trim(),
                      cartaoPlanoSaude: cpsController.text.trim(),
                      alergia: alergiaMarcada,
                      doador: doadorMarcado,
                    );

                    Pessoa pessoaAtualizado =
                        await PersonUpdateService.getPerson(pessoaAtualizada);
                    // ignore: unnecessary_null_comparison
                    if (pessoaAtualizado != null) {
                      setState(() {
                        widget.pessoa = pessoaAtualizado;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Dados atualizados com sucesso!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    } else {
                      print("id: ${pessoaAtualizada.pessoaId?.trim()}");
                      print("Nome: ${pessoaAtualizada.nome?.trim()}");
                      print("CPF: ${pessoaAtualizada.cpf?.trim()}");
                      print("Email: ${pessoaAtualizada.email?.trim()}");
                      print("Contato: ${pessoaAtualizada.contato}");
                      print(
                          "Data de Nascimento: ${pessoaAtualizada.dataNascimento?.trim()}");
                      print("tipoSanguineo: ${pessoaAtualizada.tipoSanguineo}");
                      print("alergia: ${pessoaAtualizada.alergia}");
                      print('doador:${pessoaAtualizada.doador}');
                      print("responsavel: ${pessoaAtualizada.tipoResponsavel}");
                      print("tipoAlergia: ${pessoaAtualizada.tipoAlergia}");
                      print(
                          "cartaoNacional: ${pessoaAtualizada.cartaoNacional}");
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
        ),
      ),
    );
  }
}
