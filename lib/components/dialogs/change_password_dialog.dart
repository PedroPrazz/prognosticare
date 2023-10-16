import 'package:flutter/material.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/components/common_widgets/custom_text_field.dart';
import '../../src/api/service/change_password_service.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({Key? key});

  Future<bool?> updatePassword(BuildContext context) {
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController =
        TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
            key: _formKey,
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
                        validator: (senha) {
                          if (senha == null || senha.trim().isEmpty) {
                            return 'Digite sua senha!';
                          }
                          if (senha.trim().length < 8) {
                            return 'Digite uma senha com pelo menos 8 caracteres.';
                          }
                          if (newPasswordController.text.trim() !=
                              confirmNewPasswordController.text.trim()) {
                            return 'As senhas não coincidem';
                          }
                          return null;
                        },
                      ),

                      // Confirmar senha
                      CustomTextField(
                        controller: confirmNewPasswordController,
                        icon: Icons.lock,
                        label: 'Confirmar Nova senha',
                        isSecret: true,
                        validator: (confirmSenha) {
                          if (confirmSenha == null ||
                              confirmSenha.trim().isEmpty) {
                            return 'Confirme sua senha!';
                          }
                          if (newPasswordController.text.trim() !=
                              confirmNewPasswordController.text.trim()) {
                            return 'As senhas não coincidem';
                          }
                          return null;
                        },
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
                            if (_formKey.currentState!.validate()) {
                              print('Todos os campos estão válidos');
                            } else {
                              print('Campos não válidos');
                            }
                            if (newPasswordController.text.trim().isEmpty ||
                                newPasswordController.text.trim().length < 8 ||
                                confirmNewPasswordController.text
                                    .trim()
                                    .isEmpty ||
                                newPasswordController.text.trim() !=
                                    confirmNewPasswordController.text.trim()) {
                              return;
                            }
                            bool changePassword =
                                await ChangePasswordService.getChangePassword(
                                    newPasswordController.text.trim());
                            if (changePassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Senha alterada com sucesso! Faça login novamente.'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()),
                                  (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Não foi possível alterar a senha.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
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
