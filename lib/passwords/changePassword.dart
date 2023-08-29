import 'package:flutter/material.dart';
import 'package:prognosticare/api/service/changePasswordService.dart';
import 'package:prognosticare/login.dart';
import '../homePage.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _password = TextEditingController();
    return Scaffold(
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  child: Column(children: [
                Container(
                    margin: EdgeInsets.all(25),
                    child: Text(
                      'Alterar Senha',
                      style: TextStyle(fontSize: 37, fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 30),
                Container(
                  width: 500,
                  child: TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                        labelText: 'Nova senha',
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
                Container(
                  width: 500,
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Confirmar Nova Senha',
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
                  onPressed: () async {
                    bool changePassword = await ChangePasswordService.getChangePassword(_password.text);
                    if(changePassword){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      print('Senha alterada com sucesso!');
                    }else{
                      print('As senhas não coincidem. Tente novamente!');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                    alignment: Alignment.center,
                  ),
                  child: Container(
                      width: 465,
                      height: 39,
                      child: Center(child: Text('ALTERAR SENHA'))),
                ),
              ]))),
        ));
  }
}
