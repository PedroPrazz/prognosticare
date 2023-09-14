import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:prognosticare/src/api/service/personUpdateService.dart';
import 'package:prognosticare/src/models/pessoa.dart';
import 'package:prognosticare/src/pages/base/base_screen.dart';

class MyProfile extends StatefulWidget {
  MyProfile({super.key, required this.pessoa});

  final Pessoa pessoa;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  TextEditingController _nome = TextEditingController();
  TextEditingController _cpf = TextEditingController();
  TextEditingController _contato = TextEditingController();
  TextEditingController _data = TextEditingController();
  TextEditingController _tipoSanguineo = TextEditingController();
  TextEditingController _tipoAlergia = TextEditingController();
  TextEditingController _cartaoNacional = TextEditingController();
  TextEditingController _cartaoPlanoSaude = TextEditingController();

  bool doadorMarcado = false;
  bool alergiaMarcada = false;

  DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _nome.text = widget.pessoa.nome;
    _cpf.text = widget.pessoa.cpf;
    _contato.text = widget.pessoa.contato.toString();
    DateTime parsedDate = DateTime.parse(widget.pessoa.dataNascimento);
    _data.text = _dateFormat.format(parsedDate);
    _tipoSanguineo.text = widget.pessoa.tipoSanguineo ?? 'A_POSITIVO';
    _tipoAlergia.text = widget.pessoa.tipoAlergia.toString();
    _cartaoNacional.text = widget.pessoa.cartaoNacional.toString();
    _cartaoPlanoSaude.text = widget.pessoa.cartaoPlanoSaude.toString();
  }

  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.pessoa.nome),
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
                      enabled: false,
                      controller: _nome,
                      decoration: InputDecoration(
                          hintText: widget.pessoa.nome,
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
                      enabled: false,
                      controller: _cpf,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ],
                      decoration: InputDecoration(
                          hintText: widget.pessoa.cpf,
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
                      enabled: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter(),
                      ],
                      controller: _data,
                      decoration: InputDecoration(
                          hintText: widget.pessoa.dataNascimento,
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
                      value: _tipoSanguineo.text.isEmpty
                          ? null
                          : _tipoSanguineo.text,
                      onChanged: (String? newValue) {
                        setState(() {
                          _tipoSanguineo.text = newValue!;
                        });
                      },
                      items: <String>[
                        'A_POSITIVO',
                        'A_NEGATIVO',
                        'B_POSITIVO',
                        'B_NEGATIVO',
                        'O_POSITIVO',
                        'O_NEGATIVO',
                        'AB_POSITIVO',
                        'AB_NEGATIVO',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(Icons.bloodtype,
                                  color: Color.fromRGBO(255, 143, 171, 1)),
                              SizedBox(width: 10),
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
                      DateTime parsedDate = _dateFormat.parse(_data.text);
                      String originalDate =
                          "${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year.toString()}";

                      Pessoa pessoaAtualizada = widget.pessoa.copyWith(
                        pessoaId: widget.pessoa.pessoaId,
                        nome: _nome.text,
                        cpf: _cpf.text,
                        contato: _contato.text,
                        dataNascimento: originalDate,
                        tipoSanguineo: _tipoSanguineo.text,
                        alergia: alergiaMarcada,
                        tipoAlergia: _tipoAlergia.text,
                        tipoResponsavel: widget.pessoa.tipoResponsavel,
                        cartaoNacional: _cartaoNacional.text,
                        cartaoPlanoSaude: _cartaoPlanoSaude.text,
                      );
                      bool update = false;
                         // await PersonUpdateService.getPerson(pessoaAtualizada);
                      if (update) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BaseScreen()));
                      } else {
                        print("id: ${pessoaAtualizada.pessoaId}");
                        print("Nome: ${pessoaAtualizada.nome}");
                        print("CPF: ${pessoaAtualizada.cpf}");
                        print("Contato: ${pessoaAtualizada.contato}");
                        print(
                            "Data de Nascimento: ${pessoaAtualizada.dataNascimento}");
                        print(
                            "tipoSanguineo: ${pessoaAtualizada.tipoSanguineo}");
                        print("alergia: ${pessoaAtualizada.alergia}");
                        print(
                            "responsavel: ${pessoaAtualizada.tipoResponsavel}");
                        print("tipoAlergia: ${pessoaAtualizada.tipoAlergia}");
                        print(
                            "cartaoNacional: ${pessoaAtualizada.cartaoNacional}");
                        print(
                            "cartaoPlanoSaude: ${pessoaAtualizada.cartaoPlanoSaude}");
                      }
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
