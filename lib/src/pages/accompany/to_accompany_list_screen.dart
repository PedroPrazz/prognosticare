import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/to_accompany_list_service.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';
import 'package:prognosticare/src/pages/accompany/to_accompany_screen.dart';

class ToAccompanyListScreen extends StatefulWidget {
  const ToAccompanyListScreen({Key? key}) : super(key: key);

  @override
  State<ToAccompanyListScreen> createState() => _ToAccompanyListScreenState();
}

class _ToAccompanyListScreenState extends State<ToAccompanyListScreen> {
  late Future<List<Accompany>> accompanyFuture;

  String? tipoSelecionado;
  List<String> tiposAcompanhamentos = [
    'MEDICACAO',
    'PROCEDIMENTO',
  ];

  @override
  void initState() {
    super.initState();
    accompanyFuture = ToAccompanyListService.getAccompanyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Acompanhamentos'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 143, 171, 1),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Combo box para selecionar o tipo de agendamento
              DropdownButtonFormField<String>(
                value: tipoSelecionado,
                onChanged: (newValue) {
                  setState(() {
                    tipoSelecionado = newValue;
                  });
                },
                items: tiposAcompanhamentos.map((tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo,
                    child: Text(tipo),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Tipo de Acompanhamento',
                  hintText: 'Selecione um tipo de acompanhamento...',
                  border: OutlineInputBorder(),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Accompany>>(
                  future: accompanyFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child:
                              Text('Erro ao carregar a lista de acompanhamentos'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text('Nenhum acompanhamento encontrado'));
                    } else {
                      final accompany = snapshot.data!;
                      return ListView.builder(
                        itemCount: accompany.length,
                        itemBuilder: (context, index) {
                          final toaccompany = accompany[index];
                          return ListTile(
                            title: Text(toaccompany.prescricaoMedica!),
                            leading: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                              },
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                              },
                            ),
                            onTap: () {
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Spacer(), // Espaço flexível para empurrar o botão para a parte inferior
              ElevatedButton(
                onPressed: () async {
                  // Verifique se um tipo de agendamento foi selecionado
                  if (tipoSelecionado != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (c) {
                          return ToAccompanyScreen();
                        },
                      ),
                    );
                  } else {
                    // Caso contrário, mostre um aviso ao usuário
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Por favor, selecione um tipo de acompanhamento.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 143, 171, 1),
                ),
                child: Container(
                  width: double
                      .infinity, // Largura do botão definida para ocupar a largura máxima
                  height: 39,
                  child: Center(child: Text('+ ACOMPANHAR')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
