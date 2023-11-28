import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/accompany_service.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';

class AccompanyEvent extends StatefulWidget {
  String filtro;
  AccompanyEvent({Key? key, required this.filtro}) : super(key: key);

  @override
  State<AccompanyEvent> createState() => _AccompanyEventState();
}

class _AccompanyEventState extends State<AccompanyEvent> {
  late Future<List<Accompany>> accompaniesFuture;
  TextEditingController searchController = TextEditingController();
  List<Accompany> allAccompanies = [];

  void initState() {
    super.initState();
    accompaniesFuture =
        AccompanyService.getAccompanyListByFiltro(widget.filtro);
    accompaniesFuture.then((accompanies) {
      setState(() {
        allAccompanies = accompanies;
      });
    });
  }

  List<Accompany> getFilteredAccompanies(String query, String filtro) {
    return allAccompanies.where((accompany) {
      final medicacao =
          accompany.tipoAcompanhamento + " " + accompany.medicacao;
      return medicacao.toLowerCase().contains(query.toLowerCase());
    }).toList()
      ..sort(
        (a, b) {
          if (filtro == 'maior') {
            return DateTime.parse(b.dataAcompanhamento!)
                .compareTo(DateTime.parse(a.dataAcompanhamento!));
          } else if (filtro == 'igual') {
            return a.statusEvento!.compareTo(b.statusEvento!);
          } else if (filtro == 'menor') {
            return DateTime.parse(a.dataAcompanhamento!)
                .compareTo(DateTime.parse(b.dataAcompanhamento!));
          } else {
            // Caso de filtro desconhecido
            return 0;
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  accompaniesFuture =
                      Future.value(getFilteredAccompanies(value, ''));
                });
              },
              decoration: InputDecoration(
                hintText: 'Digite para pesquisar...',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Accompany>>(
              future: accompaniesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Sem eventos cadastrados.',
                      style: TextStyle(fontSize: 25, color: Colors.blue),
                    ),
                  );
                } else {
                  List<Accompany> accompanies = snapshot.data!;
                  return ListView.builder(
                    itemCount: accompanies.length,
                    itemBuilder: (context, index) {
                      final accompany = accompanies[index];
                      Color statusColor = accompany.statusEvento == "ABERTO"
                          ? Colors.green
                          : Colors.red;
                      return ListTile(
                        title: Text(
                            accompany.tipoAcompanhamento +
                                " " +
                                accompany.medicacao,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: Text(
                          accompany.statusEvento! +
                              " " +
                              accompany.dataAcompanhamento,
                          style: TextStyle(color: statusColor),
                        ),
                        onTap: () {},
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
