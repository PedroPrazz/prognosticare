import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/getFindbyIDService.dart';
import 'package:prognosticare/src/api/service/loginService.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
      reverse: true,
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                child: Column(children: [
              Container(
                  margin: EdgeInsets.only(
                      top: 180, left: 25, right: 25, bottom: 25),
                  child: Text(
                    'Login',
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
              Container(
                width: 500,
                child: TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 143, 171, 1)))),
                  cursorColor: Color.fromRGBO(255, 143, 171, 1),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Senha is required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_email.text.isEmpty || _password.text.isEmpty) {
                    // Exibir um AlertDialog se o email ou senha estiverem vazios
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Tente novamente!'),
                          content:
                              Text('O email e a senha não podem ser vazios.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Fechar o AlertDialog
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    bool loggedIn = await LoginService.getLogin(
                        _email.text, _password.text);
                    if (loggedIn) {
                      if (_password.text == 'abcdefgh') {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ChangePassword()));
                      } else {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomePage()));
                        GetFindbyIDService.getFindbyID();
                      }
                    } else {
                      // Exibir um AlertDialog se o login falhar
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Tente novamente!'),
                            content:
                                Text('Seu email e/ou senha não correspondem.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Fechar o AlertDialog
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                  alignment: Alignment.center,
                ),
                child: Container(
                  width: 465,
                  height: 39,
                  child: Center(child: Text('ENTRAR')),
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ForgotPassword(),
                  //     ));
                },
                child: Text(
                  'ESQUECEU SUA SENHA?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, color: Color.fromRGBO(255, 143, 171, 1)),
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => RegisterPage(),
                  //     ));
                },
                child: Text(
                  'PRIMEIRO ACESSO?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, color: Color.fromRGBO(255, 143, 171, 1)),
                ),
              )
            ]))),
      ),
    ));
  }
}
