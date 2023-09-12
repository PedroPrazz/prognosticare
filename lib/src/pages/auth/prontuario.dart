import 'package:flutter/material.dart';
import 'package:prognosticare/src/pages/auth/agendamentos.dart';

class Prontuario extends StatefulWidget {
  const Prontuario({Key? key}) : super(key: key);

  @override
  State<Prontuario> createState() => _ProntuarioState();
}

class _ProntuarioState extends State<Prontuario> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Prontuário'),
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Agendamentos()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height /
                          2, // Metade da altura da tela
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(
                            255, 143, 171, 1), // Cor de fundo do retângulo
                        borderRadius:
                            BorderRadius.circular(10.0), // Borda arredondada
                      ),
                      child: Align(
                        alignment: Alignment.center, // Centralizar o conteúdo
                        child: Text(
                          'Agendamentos',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Acompanhamentos()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2,
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 143, 171, 1),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          // Adicione uma sombra ao container
                          BoxShadow(
                            color: Colors.grey, // Cor da sombra
                            offset: Offset(
                                0, 2), // Deslocamento horizontal e vertical
                            blurRadius: 4, // Raio de desfoque
                          ),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Acompanhamentos',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
