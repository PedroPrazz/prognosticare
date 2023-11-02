// ignore_for_file: must_be_immutable

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:prognosticare/components/dialogs/change_password_dialog.dart';
import 'package:prognosticare/components/dialogs/forgot_password_dialog.dart';
import 'package:prognosticare/src/api/service/firebase_messaging_service.dart';
import 'package:prognosticare/src/api/service/login_service.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/api/service/profilesService.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/profilesModel.dart';
import 'package:prognosticare/src/pages/home/perfisRow.dart';
import 'package:prognosticare/src/routes/app_pages.dart';

final storage = FlutterSecureStorage();

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  bool emailValido = false;
  bool senhaValida = false;

  Future<String?> _getFCMToken() async {
    FirebaseMessagingService firebaseMessagingService =
        FirebaseMessagingService();
    String? fcmToken = await firebaseMessagingService.getFirebaseToken();
    return fcmToken;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 40,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Prognosti',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Care',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Exames'),
                            FadeAnimatedText('Prontuários'),
                            FadeAnimatedText('Consultas'),
                            FadeAnimatedText('Agendamentos'),
                            FadeAnimatedText('Vacinas'),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                      // Email
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'Email',
                        validator: (email) {
                          if (email == null || email.trim().isEmpty) {
                            return 'Digite seu email!';
                          }
                          if (!email.trim().isEmail) {
                            return 'Digite um email válido!';
                          }
                          emailValido = true;
                          return null;
                        },
                      ),

                      // Senha
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: (senha) {
                          if (senha == null || senha.trim().isEmpty) {
                            return 'Digite sua senha!';
                          }
                          if (senha.trim().length < 8) {
                            return 'Senha deve conter no mínimo 8 caracteres!';
                          }
                          senhaValida = true;
                          return null;
                        },
                      ),

                      // Botão de Entrar
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
                            if (!emailValido || !senhaValida) {
                              return;
                            }
                            bool loggedIn = await LoginService.getLogin(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                context);
                            if (loggedIn) {
                              if (passwordController.text.trim() ==
                                  'abcdefgh') {
                                ChangePasswordDialog().updatePassword(context);
                              } else {
                                String? idPessoa = await storage.read(key: 'user_id');
                                String? nome = await storage.read(key: 'nome');

                                Profile pessoaResponsavel = Profile(pessoaId: idPessoa, nome: nome, ativo: true, tipoResponsavel: true);
                                List<Profile> profiles = await ProfileService.getProfiles(idPessoa);

                                if (profiles.isNotEmpty) {
                                  profiles.add(pessoaResponsavel);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PerfisRow(
                                              profiles: profiles,
                                            )),
                                  );
                                } else {
                                  Get.offNamed(PagesRoutes.homeRoute);
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Email e/ou senha incorretos!',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Entrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      // Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            ForgotPasswordDialog().forgotPassword(context);
                          },
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          ),
                        ),
                      ),

                      // Divisor
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('OU'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Botão de novo usuário
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            side: BorderSide(
                              width: 2,
                              color: CustomColors.customSwatchColor,
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(PagesRoutes.signUpRoute);
                          },
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
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
        ),
      ),
    );
  }
}
