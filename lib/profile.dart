import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prognosticare/api/model/pessoa.dart';
import 'package:prognosticare/api/service/personUpdateService.dart';

class MyProfile extends StatefulWidget {
  MyProfile({super.key, required this.pessoa});

  Future<Pessoa> pessoa;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  bool alergiaMarcada = false;
  bool doadorMarcado = false;
  

  Widget build(BuildContext context) {
    TextEditingController _nome = TextEditingController();
    TextEditingController _cpf = TextEditingController();
    TextEditingController _contato = TextEditingController();
    TextEditingController _data = TextEditingController();
    final TextEditingController _tipoSanguineo = TextEditingController();
    TextEditingController _tipoAlergia = TextEditingController();
    TextEditingController _cartaoNacional = TextEditingController();
    TextEditingController _cartaoPlanoSaude = TextEditingController();


    return Center(
      child: Scaffold(
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
                      controller: _nome,
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
                      controller: _contato,
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
                      controller: _cartaoNacional,
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
                      controller: _cartaoPlanoSaude,
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
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      focusColor: Colors.white,
                      decoration: InputDecoration(
                        hoverColor: Colors.blue,
                        labelText: 'Tipo Sanguíneo',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(255, 143, 171, 1),
                          ),
                        ),
                      ),
                      value: _tipoSanguineo.text.isEmpty ? null : _tipoSanguineo.text,
                      onChanged: (String? newValue) {
                        setState(() {
                          _tipoSanguineo.text = newValue!;
                        });
                      },
                      items: <String>[
                        'A+',
                        'A-',
                        'B+',
                        'B-',
                        'O+',
                        'O-',
                        'AB+',
                        'AB-'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(Icons.bloodtype,
                                  color: Color.fromRGBO(255, 143, 171,
                                      1)), // Ícone que você pode personalizar
                              SizedBox(
                                  width:
                                      10), // Espaçamento entre o ícone e o texto
                              Text(
                                value,
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 143, 171, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tipo sanguíneo is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 300,
                    child: CheckboxListTile(
                      title: Text('Alergia a Medicamentos?'),
                      value: alergiaMarcada,
                      controlAffinity: ListTileControlAffinity.leading,
                      checkColor: Color.fromRGBO(255, 143, 171, 1),
                      onChanged: (bool? value) {
                        setState(() {
                          alergiaMarcada = value!;
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: alergiaMarcada,
                    child: Container(
                      width: 500,
                      child: TextFormField(
                        controller: _tipoAlergia,
                        decoration: InputDecoration(
                          labelText: 'Tipo de Alergia',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 143, 171, 1)),
                          ),
                        ),
                        cursorColor: Color.fromRGBO(255, 143, 171, 1),
                        // validator e outras propriedades...
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 300,
                    child: CheckboxListTile(
                      title: Text('Doador de orgãos?'),
                      value: doadorMarcado,
                      controlAffinity: ListTileControlAffinity.leading,
                      checkColor: Color.fromRGBO(255, 143, 171, 1),
                      onChanged: (bool? value) {
                        setState(() {
                          doadorMarcado = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                    // Pessoa pessoa = new Pessoa(nome: _nome.text, cpf: cpf.text, contato: contato.text,
                    //  dataNascimento: dataNascimento.text, tipoSanguineo: tipoSanguineo.text, alergia: alergia.text, 
                    //  tipoAlergia: tipoAlergia.text, tipoResponsavel: tipoResponsavel.text, cartaoNacional: cartaoNacional.text, 
                    //  cartaoPlanoSaude: cartaoPlanoSaude.text);

                    // bool updatePerson = await PersonUpdateService.getPerson(Pessoa())
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
      ),
    );
  }
}
