// imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prognosticare/components/changePassword.dart';
import 'package:prognosticare/components/validation.dart';
import 'package:prognosticare/src/api/service/loginService.dart';
import 'package:prognosticare/src/pages/auth/forgotPassword.dart';
import 'package:prognosticare/src/pages/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/pages_routes/app_pages.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

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
                              color: Colors.pink,
                            ),
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
                          if (email == null || email.isEmpty)
                            return 'Digite seu email!';

                          if (!email.isEmail) return 'Digite um email válido!';

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
                          if (senha == null || senha.isEmpty) {
                            return 'Digite sua senha!';
                          }
                          if (senha.length < 8) {
                            return 'Digite uma senha com pelo menos 7 caracteres.';
                          }
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
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ValidationAlertDialog().camposVaziosAlert(context);
                              return;
                            }

                            if (!emailController.text.contains("@")) {
                              ValidationAlertDialog().emailInvalidoAlert(context);
                              return;
                            }

                            if (passwordController.text.length < 8) {
                              ValidationAlertDialog().senhaInvalidaAlert(context);
                              return;
                            }

                            bool loggedIn = await LoginService.getLogin(
                                emailController.text, passwordController.text);
                            if (loggedIn) {
                              if (passwordController.text == 'abcdefgh') {
                                ChangePasswordDialog().updatePassword(context);
                              } else {
                                Get.offNamed(PagesRoutes.homeRoute);
                              }
                            } else {
                              ValidationAlertDialog().loginSenhaInvalidoAlert(context);
                              print(
                                  'Seu email e senha não correspondem. Tente novamente!');
                              return;
                            }

                            if (_formKey.currentState!.validate()) {
                              print('Todos os campos estão válidos');
                            } else {
                              print('Campos não válidos');
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
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ForgotPassword()));
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
                              child: Text('Ou'),
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
