import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prognosticare/cadastro.dart';
import 'package:prognosticare/recuperarsenha.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  Future<void> getLogin(
      BuildContext context, String email, String password) async {
    var url = Uri.parse('http://localhost:8080/login');

    try {
      var response = await http.post(
        url,
        body: json.encode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseBody = response.body;

        var dados = json.decode(responseBody);

        print('Aqui é o TOKEN: ' + dados['token']);

        print('AQUI é o ID PESSOA: ' + dados['pessoaEntity']);

        getFindById(id){

          
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        print('Código de Status da Resposta: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _senha = TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
      reverse: true,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              child: Column(children: [
            Container(
                margin: EdgeInsets.all(25),
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
                  // You can add more validation for CPF format if needed
                  return null;
                },
                // onChanged: (value) {
                //   setState(() {
                //     _cpf = value;
                //   });
                // },
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _senha,
              decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(255, 143, 171, 1)))),
              cursorColor: Color.fromRGBO(255, 143, 171, 1),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Senha is required';
                }
                // You can add more validation for email format if needed
                return null;
              },
              // onChanged: (value) {
              //   setState(() {
              //     _email = value;
              //   });
              // },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                //aQUI

                getLogin(context, _email.text, _senha.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                alignment: Alignment.center,
              ),
              child: Container(
                  width: 500, height: 39, child: Center(child: Text('ENTRAR'))),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecuperarSenha(),
                    ));
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CadastroPage(),
                    ));
              },
              child: Text(
                'PRIMEIRO ACESSO?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15, color: Color.fromRGBO(255, 143, 171, 1)),
              ),
            )
          ]))),
    ));
  }
}
