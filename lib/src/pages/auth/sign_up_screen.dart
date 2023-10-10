import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prognosticare/components/dialogs/validation.dart';
import 'package:prognosticare/src/api/service/sign_up_service.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/config/custom_colors.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isOld = false;

  final _formKey = GlobalKey<FormState>();

  final cpfFormartter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final dataFormartter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );

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
                              if (nome == null || nome.trim().isEmpty) {
                                return 'Digite seu nome completo!';
                              }
                              if (nome.trim().length < 3) {
                                return 'Nome deve ter no mínimo 3 caracteres!';
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
                              if (cpf == null || cpf.trim().isEmpty) {
                                return 'Digite seu CPF!';
                              }
                              if (GetUtils.isCpf(cpf.trim())) {
                                print('CPF Válido');
                              } else {
                                return 'CPF Inválido';
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
                              if (email == null || email.trim().isEmpty)
                                return 'Digite seu email!';
                              if (!email.trim().isEmail)
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
                              if (data == null || data.trim().isEmpty) {
                                return 'Digite sua Data de Nascimento!';
                              }
                              DateTime dataNascimento =
                                  DateFormat('dd/MM/yyyy').parse(data.trim());
                              int idade =
                                  DateTime.now().year - dataNascimento.year;
                              if (idade < 18) {
                                return 'Você deve ter mais de 18 anos!';
                              }
                              isOld = true;
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
                              if (senha == null || senha.trim().isEmpty) {
                                return 'Digite sua senha!';
                              }
                              if (senha.trim().length < 8) {
                                return 'Digite uma senha com pelo menos 8 caracteres.';
                              }
                              if (passwordController.text.trim() !=
                                  confirmPasswordController.text.trim()) {
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
                                  confirmSenha.trim().isEmpty) {
                                return 'Confirme sua senha!';
                              }
                              if (passwordController.text.trim() !=
                                  confirmPasswordController.text.trim()) {
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
                                if (nomeController.text.trim().isEmpty ||
                                    nomeController.text.trim().length < 3 ||
                                    cpfController.text.trim().isEmpty ||
                                    !GetUtils.isCpf(
                                        cpfController.text.trim()) ||
                                    emailController.text.trim().isEmpty ||
                                    !emailController.text.trim().isEmail ||
                                    dataController.text.trim().isEmpty ||
                                    !isOld ||
                                    passwordController.text.trim().isEmpty ||
                                    passwordController.text.trim().length < 8 ||
                                    confirmPasswordController.text
                                        .trim()
                                        .isEmpty ||
                                    confirmPasswordController.text
                                            .trim()
                                            .length <
                                        8 ||
                                    passwordController.text.trim() !=
                                        confirmPasswordController.text.trim()) {
                                  return;
                                }
                                bool signIn = await RegisterService.getRegister(
                                    nomeController.text.trim(),
                                    cpfController.text.trim(),
                                    emailController.text.trim(),
                                    dataController.text.trim(),
                                    passwordController.text.trim());
                                if (signIn) {
                                  ValidationAlertDialog()
                                      .cadastroSucessoAlert(context);
                                  await Future.delayed(Duration(seconds: 3));
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (c) {
                                    return SignInScreen();
                                  }));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'CPF e/ou Email já cadastrados!'),
                                      backgroundColor:
                                          Color.fromARGB(255, 212, 31, 18),
                                    ),
                                  );
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
