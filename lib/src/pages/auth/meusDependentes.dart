import 'package:flutter/material.dart';
import 'package:prognosticare/components/dialogs/dialog.dart';
import 'package:prognosticare/src/models/pessoa_model.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/profile/profile_tab.dart';
import '../../api/service/findby_id_service.dart';

List pessoa_id = [];

class MeusDependentes extends StatelessWidget {
  final String? id;
  final String? cpf;
  final String? email;
  final String? password;
  final String? datanasc;

  MeusDependentes(
      {this.id, this.cpf, this.email, this.password, this.datanasc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        title: Text('Meus Dependentes'),
        backgroundColor: Color.fromRGBO(255, 143, 171, 1),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 100,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 143, 171, 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'nome da pessoa aqui',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 15),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Meus Dados'),
              onTap: () async {
                Pessoa pessoa = await GetFindbyIDService.getFindbyID();
                print(GetFindbyIDService.getFindbyID());
                // ignore: unnecessary_null_comparison
                if (pessoa == null) {
                  print('Não tem pessoa Cadastrada');
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileTab(pessoa: pessoa)));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Meu Prontuário'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.emoji_emotions),
              title: Text('Meus Dependentes'),
              onTap: () async {
                Pessoa pessoa = await GetFindbyIDService.getFindbyID();
                print(GetFindbyIDService.getFindbyID());
                // ignore: unnecessary_null_comparison
                if (pessoa == null) {
                  print('Não tem pessoa Cadastrada');
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileTab(pessoa: pessoa)));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.auto_stories),
              title: Text('Minha Agenda'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.miscellaneous_services),
              title: Text('Alterar Senha'),
              onTap: () {
               
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Sobre o APP'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.subdirectory_arrow_left),
              title: Text('Sair do APP'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                Container(
                  height: 50,
                ),
                Container(
                  height: 250,
                  child: ListView.builder(
                      itemCount: pessoa_id.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(pessoa_id[index]),
                          trailing: IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              (() {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Confirmacao();
                                    });
                              });
                            },
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
