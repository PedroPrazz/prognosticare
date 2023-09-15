import 'package:flutter/material.dart';
import 'package:prognosticare/src/pages/common_widgets/custom_text_field.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({Key? key});

  Future<bool?> updatePassword(BuildContext context) {
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
                    const CustomTextField(
                      isSecret: true,
                      icon: Icons.lock_outlined,
                      label: 'Nova Senha',
                    ),

                    // Confirmar senha
                    const CustomTextField(
                      isSecret: true,
                      icon: Icons.lock_outlined,
                      label: 'Confirmar nova Senha',
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
                        onPressed: () {
                          // Coloque aqui a lógica para atualizar a senha
                          // Você pode acessar os valores dos campos de senha usando controladores ou estados.
                          // Certifique-se de validar e processar os dados apropriadamente.
                          // Exemplo:
                          // String novaSenha = senhaController.text;
                          // String confirmarSenha = confirmarSenhaController.text;
                          // if (novaSenha == confirmarSenha) {
                          //   // Atualize a senha aqui
                          // } else {
                          //   // Trate o caso em que as senhas não coincidem
                          // }
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
