import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    String? tipoSanguineo;
    bool isChecked = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Dados'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 143, 171, 1),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: 500,
                  child: TextFormField(
                    // controller: _nome,
                    decoration: InputDecoration(
                        labelText: 'Nome Completo',
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
                    // controller: _cpf,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.digitsOnly,
                    //   CpfInputFormatter(),
                    // ],
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
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.digitsOnly,
                    //   DataInputFormatter(),
                    // ],
                    // controller: _data,
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
                    // controller: _password,
                    decoration: InputDecoration(
                        labelText: 'Telefone',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 143, 171, 1)))),
                    cursorColor: Color.fromRGBO(255, 143, 171, 1),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Telefone is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 500,
                  child: TextFormField(
                    // controller: _password,
                    decoration: InputDecoration(
                        labelText: 'Cartão Nacional de Sáude (CNS)',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 143, 171, 1)))),
                    cursorColor: Color.fromRGBO(255, 143, 171, 1),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'CNS is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 500,
                  child: TextFormField(
                    // controller: _password,
                    decoration: InputDecoration(
                        labelText: 'Cartão do Plano de Saúde',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 143, 171, 1)))),
                    cursorColor: Color.fromRGBO(255, 143, 171, 1),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Cartão do Plano de Saúde is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 500,
                  child: TextFormField(
                    // controller: _password,
                    decoration: InputDecoration(
                        labelText: 'Alergia a Medicamentos',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 143, 171, 1)))),
                    cursorColor: Color.fromRGBO(255, 143, 171, 1),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Medicamentos is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                 Text("Qual seu tipo sanguíneo?", style: TextStyle( 
                    fontSize: 18),
                ),
                SizedBox(height: 20),
                Wrap(
                children: [
                Container(
                  width: 120,
                  child: RadioListTile( title:Text('A+'), value: 'A+', groupValue: tipoSanguineo, onChanged: (value){
                    setState(() {
                      tipoSanguineo = value.toString();
                    });
                  }),
                ),
                Container(
                  width: 120,
                  child: RadioListTile( title:Text('A-'), value: 'A-', groupValue: tipoSanguineo, onChanged: (value){
                    setState(() {
                      tipoSanguineo = value.toString();
                    });
                  }),
                ),
                Container(
                  width: 120,
                  child: RadioListTile( title:Text('B+'), value: 'B+', groupValue: tipoSanguineo, onChanged: (value){
                    setState(() {
                      tipoSanguineo = value.toString();
                    });
                  }),
                ),
                Container(
                  width: 120,
                  child: RadioListTile( title:Text('B-'), value: 'B-', groupValue: tipoSanguineo, onChanged: (value){
                    setState(() {
                      tipoSanguineo = value.toString();
                    });
                  }),
                ),
                Container(
                  width: 120,
                  child: RadioListTile( title:Text('AB+'), value: 'AB+', groupValue: tipoSanguineo, onChanged: (value){
                    setState(() {
                      tipoSanguineo = value.toString();
                    });
                  }),
                ),
                Container(
                  width: 120,
                  child: RadioListTile( title:Text('AB-'), value: 'AB-', groupValue: tipoSanguineo, onChanged: (value){
                    setState(() {
                      tipoSanguineo = value.toString();
                    });
                  }),
                ),
                Container(
                  width: 120,
                  child: RadioListTile( title:Text('O+'), value: 'O+', groupValue: tipoSanguineo, onChanged: (value){
                    setState(() {
                      tipoSanguineo = value.toString();
                    });
                  }),
                ),
                Container(
                  width: 120,
                  child: RadioListTile( title:Text('O-'), value: 'O-', groupValue: tipoSanguineo, onChanged: (value){
                    setState(() {
                      tipoSanguineo = value.toString();
                    });
                  }),
                )
            ],
          ),
          SizedBox(height: 30),
          CheckboxListTile(
            title: Text('Doador de orgãos?'),
            value: isChecked,
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Color.fromRGBO(255, 143, 171, 1),
            onChanged: (bool? value){
              setState(() {
                isChecked = value!;
              });
            },
          ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                    alignment: Alignment.center,
                  ),
                  child: Container(
                      width: 465,
                      height: 39,
                      child: Center(child: Text('SALVAR'))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}