import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prognosticare/home.dart';
import 'package:prognosticare/login.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController _cpf = TextEditingController();
  TextEditingController _data = TextEditingController();

  DateTime? parseBrazilianDate(String date) {
    try {
      final parts = date.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  final _formKey = GlobalKey<FormState>();
  // String _cpf = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _datanasc = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // print('CPF: $_cpf');
      print('Email: $_email');
      print('Password: $_password');
      print('Data de Nascimento: $_datanasc');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.all(25),
                    child: Text(
                      'Primeiro Acesso',
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    )),
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
                      // You can add more validation for CPF format if needed
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        // _cpf = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
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
                    // You can add more validation for email format if needed
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter(),
                  ],
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
                    // You can add more validation for email format if needed
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _datanasc = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
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
                    // You can add more complex password validation if needed
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
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
                    if (value != _password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _confirmPassword = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    String cpf = _cpf.text;
                    String data = _data.text;

                    if (GetUtils.isCpf(cpf)) {
                      print('Cpf Válido');
                    } else {
                      print('Cpf Inválido');
                    }

                    DateTime? birthDate = parseBrazilianDate(_datanasc);
                    if (birthDate != null) {
                      final now = DateTime.now();
                      final age = now.year -
                          birthDate.year -
                          (birthDate.isAfter(
                                  DateTime(now.year, now.month, now.day))
                              ? 1
                              : 0);

                      if (age >= 18) {
                        print('Maior de idade');
                      } else {
                        print('Menor de idade');
                      }
                    } else {
                      print('Data Inválida');
                    }

                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            // cpf: _cpf,
                            email: _email,
                            password: _password,
                            datanasc: _datanasc,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                    alignment: Alignment.center,
                  ),
                  child: Container(
                      width: 500,
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
