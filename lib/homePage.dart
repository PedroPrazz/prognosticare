import 'package:flutter/material.dart';
import 'package:prognosticare/passwords/changePassword.dart';
import 'package:prognosticare/profile.dart';
import 'package:prognosticare/src/auth/prontuario.dart';
import '../../api/model/pessoa.dart';
import '../../api/service/getFindbyIDService.dart';
import 'src/auth/sign_in_screen.dart';

// class Event {
//   final String name;
//   final String eventType;
//   final DateTime dateTime;

//   Event(this.name, this.eventType, this.dateTime);
// }

class HomePage extends StatelessWidget {
  final String? nome;
  final String? cpf;
  final String? email;
  final String? password;
  final String? datanasc;

  HomePage({this.nome, this.cpf, this.email, this.password, this.datanasc});

  // final List<Event> events = [
  //   Event("Evento 1", "Tipo A", DateTime.now().subtract(Duration(days: 1))),
  //   Event("Evento 2", "Tipo B", DateTime.now()),
  //   Event("Evento 3", "Tipo C", DateTime.now().add(Duration(days: 1))),
  // ];

  // List<Event> getEventsForDay(DateTime day) {
  //   return events.where((event) =>
  //       event.dateTime.day == day.day &&
  //       event.dateTime.month == day.month &&
  //       event.dateTime.year == day.year).toList();
  // }

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
        title: Text('PrognostiCare'),
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
                if (pessoa == null) {
                  print('Não tem pessoa Cadastrada');
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyProfile(pessoa: pessoa)));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Meu Prontuário'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Prontuario()));
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_emotions),
              title: Text('Meus Dependentes'),
              onTap: () {},
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePassword()));
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
