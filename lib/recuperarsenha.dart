import 'package:flutter/material.dart';
import 'package:prognosticare/senhanova.dart';

class RecuperarSenha extends StatelessWidget {
  const RecuperarSenha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
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
              ElevatedButton(
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NovaSenha(),
                      ),
                    );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                  alignment: Alignment.center,
                ),
                child: Container(
                    width: 500,
                    height: 39,
                    child: Center(child: Text('RECUPERAR SENHA'))),
              ),
              SizedBox(height: 30),
              Text('Será enviado um email com instruções de recuperação de senha!')
            ]
          )
        )
      )
    );
  }
}