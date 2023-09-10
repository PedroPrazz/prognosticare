import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:prognosticare/components/custom_colors.dart';
import 'package:prognosticare/components/custom_text_field.dart';
import 'package:prognosticare/src/auth/sign_up_screen.dart';
// import 'package:prognosticare/components/custom_colors.dart';
// import 'package:prognosticare/api/service/getFindbyIDService.dart';
// import 'package:prognosticare/api/service/loginService.dart';
// import 'package:prognosticare/passwords/changePassword.dart';
// import 'package:prognosticare/passwords/forgotPassword.dart';
// import 'package:prognosticare/register.dart';
// import '../../homePage.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 143, 171, 1),
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Logo App
                      Image.asset(
                        'assets/images/logo.png',
                        width: 200,
                        height: 200,
                      ),
                      //Serviços App
                      SizedBox(
                        height: 30,
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                          child: AnimatedTextKit(
                            pause: Duration.zero,
                            repeatForever: true,
                            animatedTexts: [
                              FadeAnimatedText('Exames'),
                              FadeAnimatedText('Consultas'),
                              FadeAnimatedText('Internações'),
                              FadeAnimatedText('Vacinas'),
                              FadeAnimatedText('Cirurgias'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Formulário

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 40,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //E-mail
                      CustomTextField(
                        icon: Icons.email,
                        label: 'E-mail',
                        isSecret: false,
                        decoration: InputDecoration(
                            labelText: 'E-mail',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(255, 143, 171, 1)))),
                      ),
                      //Senha
                      CustomTextField(
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 143, 171, 1),
                            ),
                          ),
                        ),
                      ),
                      //Botão entrar
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      //Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Esqueci a senha!',
                            style: TextStyle(color: Colors.pink.shade700),
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Ou',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 16,
                                ),
                              ),
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
                      //Botão Primeiro acesso
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            side: BorderSide(
                              width: 2,
                              color: Colors.pink,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInUpScreen(),
                                ));
                          },
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
        //     body: Column(
        //   children: [
        //     SingleChildScrollView(
        //       reverse: true,
        //       child: Center(
        //         child: Padding(
        //             padding: const EdgeInsets.all(16.0),
        //             child: Form(
        //                 child: Column(children: [
        //               Expanded(
        //                 child: Container(
        //                     child: Image.asset(
        //                   'assets/images/logo.png',
        //                 )),
        //               ),
        //               Expanded(
        //                 child: Container(
        //                   width: 500,
        //                   decoration: const BoxDecoration(
        //                     color: Colors.white,
        //                     borderRadius: BorderRadiusDirectional.vertical(
        //                         top: Radius.circular(45),
        //                   ),
        //                   child: Column(
        //                     children: [],
        //                     controller: _email,
        //                     decoration: InputDecoration(
        //                         labelText: 'Email',
        //                         labelStyle: TextStyle(color: Colors.black),
        //                         border: OutlineInputBorder(
        //                             borderRadius: BorderRadius.circular(10)),
        //                         focusedBorder: OutlineInputBorder(
        //                             borderSide: BorderSide(
        //                                 color: CustomColors.customSwatchColor))),
        //                     cursorColor: CustomColors.customContrastColor,
        //                     validator: (value) {
        //                       if (value == null || value.isEmpty) {
        //                         return 'Email is required';
        //                       }
        //                       return null;
        //                     },
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 width: 500,
        //                 child: TextFormField(
        //                   controller: _password,
        //                   decoration: InputDecoration(
        //                       labelText: 'Senha',
        //                       labelStyle: TextStyle(color: Colors.black),
        //                       border: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(10)),
        //                       focusedBorder: OutlineInputBorder(
        //                           borderSide: BorderSide(
        //                               color: Color.fromRGBO(255, 143, 171, 1)))),
        //                   cursorColor: Color.fromRGBO(255, 143, 171, 1),
        //                   obscureText: true,
        //                   validator: (value) {
        //                     if (value == null || value.isEmpty) {
        //                       return 'Senha is required';
        //                     }
        //                     return null;
        //                   },
        //                 ),
        //               ),
        //               SizedBox(height: 30),
        //               ElevatedButton(
        //                 onPressed: () async {
        //                   _formKey.currentState?.validate();
        //                   if (_email.text.isEmpty || _password.text.isEmpty) {
        //                     // Exibir um AlertDialog se o email ou senha estiverem vazios
        //                     showDialog(
        //                       context: context,
        //                       builder: (BuildContext context) {
        //                         return AlertDialog(
        //                           title: Text('Tente novamente!'),
        //                           content: Text(
        //                               'O email e a senha não podem ser vazios.'),
        //                           actions: [
        //                             TextButton(
        //                               onPressed: () {
        //                                 Navigator.of(context)
        //                                     .pop(); // Fechar o AlertDialog
        //                               },
        //                               child: Text('OK'),
        //                             ),
        //                           ],
        //                         );
        //                       },
        //                     );
        //                   } else {
        //                     bool loggedIn = await LoginService.getLogin(
        //                         _email.text, _password.text);
        //                     if (loggedIn) {
        //                       if (_password.text == 'abcdefgh') {
        //                         Navigator.push(
        //                             context,
        //                             MaterialPageRoute(
        //                                 builder: (context) => ChangePassword()));
        //                       } else {
        //                         Navigator.push(
        //                             context,
        //                             MaterialPageRoute(
        //                                 builder: (context) => HomePage()));
        //                         GetFindbyIDService.getFindbyID();
        //                       }
        //                     } else {
        //                       // Exibir um AlertDialog se o login falhar
        //                       showDialog(
        //                         context: context,
        //                         builder: (BuildContext context) {
        //                           return AlertDialog(
        //                             title: Text('Tente novamente!'),
        //                             content: Text(
        //                                 'Seu email e/ou senha não correspondem.'),
        //                             actions: [
        //                               TextButton(
        //                                 onPressed: () {
        //                                   Navigator.of(context)
        //                                       .pop(); // Fechar o AlertDialog
        //                                 },
        //                                 child: Text('OK'),
        //                               ),
        //                             ],
        //                           );
        //                         },
        //                       );
        //                     }
        //                   }
        //                 },
        //                 style: ElevatedButton.styleFrom(
        //                   backgroundColor: Color.fromRGBO(255, 143, 171, 1),
        //                   alignment: Alignment.center,
        //                 ),
        //                 child: Container(
        //                   width: 465,
        //                   height: 39,
        //                   child: Center(child: Text('ENTRAR')),
        //                 ),
        //               ),
        //               SizedBox(height: 30),
        //               TextButton(
        //                 onPressed: () {
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                         builder: (context) => ForgotPassword(),
        //                       ));
        //                 },
        //                 child: Text(
        //                   'ESQUECEU SUA SENHA?',
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                       fontSize: 15,
        //                       color: Color.fromRGBO(255, 143, 171, 1)),
        //                 ),
        //               ),
        //               SizedBox(height: 30),
        //               TextButton(
        //                 onPressed: () {
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                         builder: (context) => RegisterPage(),
        //                       ));
        //                 },
        //                 child: Text(
        //                   'PRIMEIRO ACESSO?',
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                       fontSize: 15,
        //                       color: Color.fromRGBO(255, 143, 171, 1)),
        //                 ),
        //               )
        //             ]))),
        //       ),
        //     ),
        //   ],
        // ));
        );
  }
}
