import 'package:flutter/material.dart';

class ValidationAlertDialog extends StatelessWidget {
  const ValidationAlertDialog({Key? key});

  //alerta de cadastro com sucesso
  Future<void> cadastroSucessoAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cadastro realizado com sucesso!'),
          content: Text('Aproveite o PrognostiCare!'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
