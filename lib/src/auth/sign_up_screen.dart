import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/api/service/registerService.dart';
import 'package:prognosticare/src/auth/components/custom_text_field.dart';
import 'package:prognosticare/src/auth/sign_in_screen.dart';
import 'package:prognosticare/src/config/custom_colors.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final cpfFormartter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final dataFormartter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-8]')},
  );

  // final phoneFormartter = MaskTextInputFormatter(
  //   mask: '###.###.###-##',
  //   filter: {'#': RegExp( r'[0-9]')},
  // );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final nomeController = TextEditingController();
    final cpfController = TextEditingController();
    final emailController = TextEditingController();
    final dataController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),

                  // Formulário
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Nome
                          CustomTextField(
                            icon: Icons.person,
                            label: 'Nome',
                            controller: nomeController,
                            validator: (nome) {
                              if (nome == null || nome.isEmpty) {
                                return 'Digite seu nome completo!';
                              }
                              return null;
                            },
                          ),

                          // CPF
                          CustomTextField(
                            icon: Icons.file_copy,
                            label: 'CPF',
                            inputFormatters: [cpfFormartter],
                            controller: cpfController,
                            validator: (cpf) {
                              if (cpf == null || cpf.isEmpty) {
                                return 'Digite seu cpf!';
                              }
                              if (GetUtils.isCpf(cpf)) {
                                print('Cpf Válido');
                              } else {
                                return 'Cpf Inválido';
                              }
                              return null;
                            },
                          ),

                          // Email
                          CustomTextField(
                            icon: Icons.email,
                            label: 'Email',
                            controller: emailController,
                            validator: (email) {
                              if (email == null || email.isEmpty)
                                return 'Digite seu email!';

                              if (!email.isEmail)
                                return 'Digite um email válido!';

                              return null;
                            },
                          ),

                          // Data de Nascimento
                          CustomTextField(
                            icon: Icons.date_range,
                            label: 'Data de Nascimento',
                            controller: dataController,
                            inputFormatters: [dataFormartter],
                            validator: (data) {
                              if (data == null || data.isEmpty) {
                                return 'Digite sua Data de Nascimento!';
                              }
                              DateTime dataNascimento =
                                  DateFormat('dd/MM/yyyy').parse(data);
                              int idade =
                                  DateTime.now().year - dataNascimento.year;
                              if (idade < 18) {
                                return 'Para realizar o cadastro você deve ser maior de idade!';
                              }
                              return null;
                            },
                          ),

                          // Senha
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Senha',
                            isSecret: true,
                            controller: passwordController,
                            validator: (senha) {
                              if (senha == null || senha.isEmpty) {
                                return 'Digite sua senha!';
                              }
                              if (senha.length < 8) {
                                return 'Digite uma senha com pelo menos 7 caracteres.';
                              }
                              if (confirmPasswordController.text !=
                                  passwordController.text) {
                                return 'As senhas não coincidem';
                              }
                              return null;
                            },
                          ),

                          // Confirmar Senha
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Confirmar Senha',
                            isSecret: true,
                            controller: confirmPasswordController,
                            validator: (confirmSenha) {
                              if (confirmSenha == null ||
                                  confirmSenha.isEmpty) {
                                return 'Confirme sua senha!';
                              }
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                return 'As senhas não coincidem';
                              }
                              return null;
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
                                bool signIn = await RegisterService.getRegister(
                                    nomeController.text,
                                    cpfController.text,
                                    emailController.text,
                                    dataController.text,
                                    passwordController.text);
                                if (signIn) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (c) {
                                    return SignInScreen();
                                  }));
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
                    ),
                  ),
                ],
              ),

              // Botão de voltar
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
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
