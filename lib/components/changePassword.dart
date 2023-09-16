import 'package:flutter/material.dart';
import 'package:prognosticare/components/validation.dart';
import 'package:prognosticare/src/api/service/forgotPasswordService.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/common_widgets/custom_text_field.dart';

import '../src/api/service/changePasswordService.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({Key? key});

  Future<bool?> updatePassword(BuildContext context) {
    TextEditingController _newPasswordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
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
                        'Alteração de senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Nova senha
                    CustomTextField(
                      controller: _newPasswordController,
                      icon: Icons.lock,
                      label: 'Senha',
                      isSecret: true,     
                    ),

                    // Confirmar senha
                    CustomTextField(
                      controller: _confirmPasswordController,
                      icon: Icons.lock,
                      label: 'Confirmar Nova senha',
                      isSecret: true,
                    ),

                    //Botão de confirmação
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          String novaSenha = _newPasswordController.text;
                          String confirmarSenha =
                              _confirmPasswordController.text;
                          if (novaSenha == confirmarSenha && novaSenha!= '' && confirmarSenha != '' && novaSenha.length >8 && confirmarSenha.length >8) {
                            bool changePassword =
                                await ChangePasswordService.getChangePassword(
                                    _newPasswordController.text);
                            if (changePassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Senha Alterada com Sucesso!'),
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

                            if(changePassword == false){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Tente novamente mais tarde!'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor:
                                      Color.fromARGB(222, 212, 10, 10),
                                ),
                              );
                             
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()));
                            }

                          } 
                          
                          if (_newPasswordController.text.length < 8 || _confirmPasswordController.text.length < 8) {
                              ValidationAlertDialog().senhaInvalidaAlert(context);
                              return;
                            }
                            
                        },
                        child: const Text(
                          'Alterar',
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
