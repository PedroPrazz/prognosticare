import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/dependent_list_service.dart';
import 'package:prognosticare/src/models/dependent_model.dart';
import 'package:prognosticare/src/pages/profile/profile_tab_dependente.dart';

class ListDependents extends StatefulWidget {
  ListDependents({Key? key}) : super(key: key);

  @override
  _ListDependentsState createState() => _ListDependentsState();
}

class _ListDependentsState extends State<ListDependents> {
  late Future<List<Dependente>> dependentsFuture;

  @override
  void initState() {
    super.initState();
    dependentsFuture = DependentListService.getDependentList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Dependentes'),
      ),
      body: FutureBuilder<List<Dependente>>(
        future: dependentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar a lista de dependentes'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum dependente encontrado'));
          } else {
            final dependentes = snapshot.data!;
            return ListView.builder(
              itemCount: dependentes.length,
              itemBuilder: (context, index) {
                final dependente = dependentes[index];
                return ListTile(
                  title: Text(dependente.nome),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) {
                        return ProfileTabDepentende();
                      },
                    ));
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (c) {
              return ProfileTabDepentende();
            },
          ));
        },
        label: Text(
          'ADICIONAR DEPENDENTE',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
