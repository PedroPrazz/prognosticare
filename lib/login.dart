import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override

final _formKey = GlobalKey<FormState>();
  String _cpf = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process the data
      // You can add your logic here to handle the form submission
      print('CPF: $_cpf');
      print('Email: $_email');
      print('Password: $_password');
    }
  }  

  Widget build(BuildContext context) {
    return Scaffold(
     body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(25),
                child: Text('Primeiro Acesso',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold
                ),)),
              SizedBox(height: 30),
              Container(
                width: 500,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'CPF',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color.fromRGBO(255, 143, 171, 1)))
                    ),
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
                      _cpf = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color.fromRGBO(255, 143, 171, 1)))
                    ),
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
                decoration: InputDecoration(labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color.fromRGBO(255, 143, 171, 1)))
                    ),
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
                decoration: InputDecoration(labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Color.fromRGBO(255, 143, 171, 1)))
                    ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                  alignment: Alignment.center,
                ),
                onPressed: _submitForm,
                child: Container(
                  width: 500,
                  height: 39,
                  child: Center(child: Text('CADASTRAR'))),
              ),
              SizedBox(height: 30),
              Text(
                  'JÁ POSSUI CONTA?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
            ],
          ),
        ),
      ),);
  }
}


