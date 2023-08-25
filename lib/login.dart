import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prognosticare/cadastro.dart';
import 'package:prognosticare/recuperarsenha.dart';
import 'home.dart';
import 'package:http/http.dart' as http;


final storage = FlutterSecureStorage();

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


        
        await storage.write(key: 'token', value: dados['token']);
        await storage.write(key: 'user_id', value: dados['user_id']);  
   

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        print('Código de Status da Resposta: ${response.statusCode}');
        print({response.body});
        print('Erro no login!');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  Future<void> fetchUserData() async {
    final token = await storage.read(key: 'token');
    final userId = await storage.read(key: 'user_id');

    final response = await http.get(
      Uri.parse('http://localhost:8080/register-person/find/$userId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('User Data: $data');
    } else {
      print('Failed to fetch user data.');
    }
  }

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
                  margin: EdgeInsets.only(top: 180, left: 25, right: 25, bottom: 25),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Senha is required';
                    }
                    // You can add more validation for email format if needed
                    return null;
                  },
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  //aQUI

                  getLogin(context, _email.text, _password.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                  alignment: Alignment.center,
                ),
                child: Container(
                    width: 465,
                    height: 39,
                    child: Center(child: Text('ENTRAR'))),
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
      ),
    ));
  }
}
