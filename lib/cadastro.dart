import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prognosticare/home.dart';
import 'package:prognosticare/login.dart';
import 'api/service/cadastroService.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}
class _CadastroPageState extends State<CadastroPage> {

  Widget build(BuildContext context) {
    TextEditingController _nome = TextEditingController();
    TextEditingController _cpf = TextEditingController();
    TextEditingController _data = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: 180, left: 25, right: 25, bottom: 25),
                    child: Text(
                      'Primeiro Acesso',
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 30),
                Container(
                  width: 500,
                  child: TextFormField(
                    controller: _nome,
                    decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 143, 171, 1)))),
                    cursorColor: Color.fromRGBO(255, 143, 171, 1),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 500,
                  child: TextFormField(
                    controller: _cpf,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    decoration: InputDecoration(
                        labelText: 'CPF',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 143, 171, 1)))),
                    cursorColor: Color.fromRGBO(255, 143, 171, 1),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'CPF is required';
                      }
                      return null;
                    },
                  ),
                ),
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter(),
                    ],
                    controller: _data,
                    decoration: InputDecoration(
                        labelText: 'Data de Nascimento',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 143, 171, 1)))),
                    cursorColor: Color.fromRGBO(255, 143, 171, 1),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data de nascimento is required';
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
                        labelText: 'Password',
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
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 500,
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
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
                        return 'Please confirm your password';
                      }
                      if (value != _password.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    String cpf = _cpf.text;

                    if (GetUtils.isCpf(cpf)) {
                      print('Cpf Válido');
                    } else {
                      print('Cpf Inválido');
                    }
                   
                   CadastroService.getCadastro(_nome.text, _cpf.text, _email.text, _data.text, _password.text);
                    if(CadastroService.getCadastro == true){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                    alignment: Alignment.center,
                  ),
                  child: Container(
                      width: 465,
                      height: 39,
                      child: Center(child: Text('CADASTRAR'))),
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  child: Text(
                    'JÁ POSSUI CONTA?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(255, 143, 171, 1)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
