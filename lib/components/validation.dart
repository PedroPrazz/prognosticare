import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/forgotPasswordService.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/common_widgets/custom_text_field.dart';

import '../src/api/service/changePasswordService.dart';

class ValidationAlertDialog extends StatelessWidget {
  const ValidationAlertDialog({Key? key});

  Future<void> camposVaziosAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('Os campos não podem estar vazios.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> emailInvalidoAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('O email é inválido!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> senhaInvalidaAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('A senha precisa conter pelo menos 8 caracteres!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> loginSenhaInvalidoAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('Seu email e/ou senha não correspondem!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
