import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:prognosticare/components/validation.dart';
import 'package:prognosticare/src/api/service/forgotPasswordService.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/common_widgets/custom_text_field.dart';

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog({Key? key});

  Future<bool?> forgotPassword(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Titulo
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Esqueci a senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    CustomTextField(
                      controller: _emailController,
                      icon: Icons.email,
                      label: 'E-mail',
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Digite o email!';
                        }
                        if (!email.isEmail) return 'Digite um email válido!';
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          if (_emailController.text != '') {
                            bool forgotPassowrd =
                                await ForgotPasswordService.getNewPassword(
                                    _emailController.text);
                            if (forgotPassowrd) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('E-mail Enviado com Sucesso!'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor:
                                      Color.fromARGB(222, 51, 212, 10),
                                  
                                ),
                              );

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()));
                            }
                            if(forgotPassowrd == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Tente novamente mais tarde!!'),
                                backgroundColor:
                                    Color.fromARGB(222, 240, 16, 16),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            print("erro ao trocar senha");
                          }

                          }
                          if (_emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Digite um Email!'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor:
                                      Color.fromARGB(222, 222, 222, 2),
                                ),
                              );
                            return;
                          }

                          if (!_emailController.text.contains("@")) {
                            ValidationAlertDialog().emailInvalidoAlert(context);
                            return;
                          } 
                          
                        },
                        child: const Text(
                          'Enviar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
