import 'package:flutter/material.dart';
import 'package:prognosticare/api/service/changePasswordService.dart';
import 'package:prognosticare/src/auth/sign_in_screen.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  // Método para mostrar o AlertDialog de campos vazios
  Future<void> mostrarCamposVaziosAlertDialog(BuildContext context) async {
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

  // Método para mostrar o AlertDialog de senhas não correspondentes
  Future<void> mostrarSenhasNaoCorrespondentesAlertDialog(
      BuildContext context) async {
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

  // Método para mostrar o AlertDialog de senhas menores que 8 caracteres
  Future<void> mostrarSenhasMenoresOitoCaracteresAlertDialog(
      BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('A senha precisa conter mais de 8 caracteres.'),
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

  // Método para mostrar o AlertDialog de senha alterada com sucesso
  Future<void> mostrarSenhaAlteradaComSucessoAlertDialog(
      BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Senha Alterada'),
          content: Text('A senha foi alterada com sucesso.'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _newPasswordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        // Ícone de voltar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Voltar para a página anterior
          },
        ),
        title: Text('Alterar Senha'),
        backgroundColor: Color.fromRGBO(255, 143, 171, 1),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                SizedBox(height: 30),
                Container(
                  width: 500,
                  child: TextFormField(
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Nova senha',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(255, 143, 171, 1),
                        ),
                      ),
                    ),
                    cursorColor: Color.fromRGBO(255, 143, 171, 1),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Senha é obrigatória';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 500,
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Nova Senha',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(255, 143, 171, 1),
                        ),
                      ),
                    ),
                    cursorColor: Color.fromRGBO(255, 143, 171, 1),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, confirme sua senha';
                      }
                      if (value != _newPasswordController.text) {
                        return 'As senhas não conferem';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_newPasswordController.text.isEmpty ||
                        _confirmPasswordController.text.isEmpty) {
                      mostrarCamposVaziosAlertDialog(context);
                    } else if (_newPasswordController.text.length < 8) {
                      mostrarSenhasMenoresOitoCaracteresAlertDialog(context);
                    } else if (_newPasswordController.text !=
                        _confirmPasswordController.text) {
                      mostrarSenhasNaoCorrespondentesAlertDialog(context);
                    } else {
                      bool changePassword =
                          await ChangePasswordService.getChangePassword(
                              _newPasswordController.text);
                      mostrarSenhaAlteradaComSucessoAlertDialog(context);
                      await Future.delayed(Duration(seconds: 5));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignInScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                    alignment: Alignment.center,
                  ),
                  child: Container(
                    width: 465,
                    height: 39,
                    child: Center(child: Text('ALTERAR SENHA')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
