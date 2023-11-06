import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/dependent_service.dart';
import 'package:prognosticare/src/models/dependent_model.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';
import 'package:prognosticare/src/pages/profile/profile_tab_dependente.dart';

class ListDependents extends StatefulWidget {
  ListDependents({Key? key}) : super(key: key);

  @override
  _ListDependentsState createState() => _ListDependentsState();
}

class _ListDependentsState extends State<ListDependents> {
  Future<List<Dependente>>? dependentsFuture;

  @override
  void initState() {
    super.initState();
    dependentsFuture = DependentService.getDependentList();
  }

  Future<void> _showDeleteConfirmationDialog(Dependente dependente) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você deseja excluir o dependente:'),
                Text(dependente.nome),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () async {
                final deleted = await DependentService.disableDependente(
                    dependente.id!);
                if (deleted) {
                  setState(() {
                    // Atualize a lista de dependentes chamando dependentsFuture novamente
                    dependentsFuture = DependentService.getDependentList();
                  });
                }
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Dependentes'),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
          },
        ),
      ),
      body: FutureBuilder<List<Dependente>>(
        future: dependentsFuture,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar a lista de dependentes'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum dependente encontrado'));
          } else {
            final dependentes = snapshot.data!;
            return ListView.builder(
              itemCount: dependentes.length,
              itemBuilder: (context, index) {
                final dependente = dependentes[index];
                if (dependente.ativo == true) {
                  return ListTile(
                    title: Text(dependente.nome),
                    leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (c) {
                            return ProfileTabDepentende(
                              dependente: dependente,
                              isEditing: true, // Modo de edição ativado
                            );
                          },
                        ));
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _showDeleteConfirmationDialog(dependente);
                      },
                    ),
                    onTap: () {
                      // Lógica para o toque no dependente
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
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
