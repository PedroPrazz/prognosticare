import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/forgotPasswordService.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  Future<void> emailValidoAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email enviado!'),
          content: Text('Foi enviado um email com instruções de recuperação.'),
        );
      },
    );
  }

  Future<void> emailInvalidoAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tente novamente!'),
          content: Text('Email não cadastrado no sistema.'),
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
    TextEditingController _email = TextEditingController();
    return Scaffold(
        body: Center(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              child: Column(children: [
            Container(
                margin: EdgeInsets.all(25),
                child: Text(
                  'Esqueci a Senha',
                  style: TextStyle(fontSize: 37, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 30),
            Container(
              width: 500,
              child: TextFormField(
                controller: _email,
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(255, 143, 171, 1)))),
                cursorColor: Color.fromRGBO(255, 143, 171, 1),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                bool sendEmail =
                    await ForgotPasswordService.getNewPassword(_email.text);
                if (sendEmail) {
                  emailValidoAlertDialog(context);
                  await Future.delayed(Duration(seconds: 5));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                } else {
                  emailInvalidoAlertDialog(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                alignment: Alignment.center,
              ),
              child: Container(
                  width: 465,
                  height: 39,
                  child: Center(child: Text('RECUPERAR SENHA'))),
            ),
            SizedBox(height: 30),
            Text(
                'Será enviado um email com instruções de recuperação de senha!')
          ]))),
    ));
  }
}
