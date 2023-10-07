import 'package:flutter/material.dart';

class ValidationAlertDialog extends StatelessWidget {
  const ValidationAlertDialog({Key? key});

  //alerta de campos vazios
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

  //alerta de email inválido
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

  //alerta de recuperar senha
  Future<void> recuperarSenhaAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email enviado com sucesso!'),
          content: Text(
              'Foi enviado um email com instruções para recuperar a senha!'),
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

  //alerta de email inexistente
  Future<void> emailInexistenteAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('O email informado não está cadastrado no sistema!'),
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

  //alerta de login e/ou senha inválidos
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

  //alerta de senhas não correspondem
  Future<void> senhasNaoCorrespondemAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('As senhas digitadas são diferentes.'),
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

  //alerta de senha inválida
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

  //alerta de senha alterada
  Future<void> senhaAlteradaAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Senha alterada com sucesso!'),
          content: Text('Agora você tem uma nova senha!'),
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

  //alerta de senha não alterada
  Future<void> naoAlterouSenhaAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('Você não alterou a senha!'),
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

  //alerta de nome inválido
  Future<void> nomeInvalidoAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('O nome precisa conter pelo menos 3 caracteres.'),
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

  //alerta de CPF inválido
  Future<void> cpfInvalidoAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('O CPF digitado é inválido.'),
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

  //alerta de menor de idade
  Future<void> menorIdadeAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('Você precisa ter mais de 18 anos para se cadastrar.'),
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
