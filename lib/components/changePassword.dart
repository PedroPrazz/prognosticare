import 'package:flutter/material.dart';
import 'package:prognosticare/components/validation.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';
import '../src/api/service/changePasswordService.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({Key? key});

  Future<bool?> updatePassword(BuildContext context) {
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController =
        TextEditingController();
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
                      controller: newPasswordController,
                      icon: Icons.lock,
                      label: 'Senha',
                      isSecret: true,
                    ),

                    // Confirmar senha
                    CustomTextField(
                      controller: confirmNewPasswordController,
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
                          if (newPasswordController.text.isEmpty ||
                              confirmNewPasswordController.text.isEmpty) {
                            return ValidationAlertDialog()
                                .camposVaziosAlert(context);
                          }

                          if (newPasswordController.text.length < 8) {
                            return ValidationAlertDialog()
                                .senhaInvalidaAlert(context);
                          }

                          if (newPasswordController.text !=
                              confirmNewPasswordController.text) {
                            return ValidationAlertDialog()
                                .senhasNaoCorrespondemAlert(context);
                          }

                          bool changePassword =
                              await ChangePasswordService.getChangePassword(
                                  newPasswordController.text);
                          if (changePassword) {
                            ValidationAlertDialog().senhaAlteradaAlert(context);
                            await Future.delayed(Duration(seconds: 5));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          } else {
                            ValidationAlertDialog()
                                .naoAlterouSenhaAlert(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
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
