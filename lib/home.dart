import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String? cpf;
  final String? email;
  final String? password;
  final String? datanasc;

  HomePage({this.cpf, this.email, this.password, this.datanasc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              // Lógica para ação do botão
            },
          ),
        ],
        title: Text('PrognostiCare'),
        backgroundColor: Color.fromRGBO(255, 143, 171, 1), // Cor de fundo
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: Drawer(
        // Adicionando o Drawer
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
                        Icons.person, // Ícone para representar o usuário
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '$cpf', // Mostra o CPF cadastrado
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
              onTap: () {
                // Lógica para navegar para a página inicial
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Meu Prontuário'),
              onTap: () {
                // Lógica para navegar para a página inicial
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_emotions),
              title: Text('Meus Dependentes'),
              onTap: () {
                // Lógica para navegar para a página inicial
              },
            ),
            ListTile(
              leading: Icon(Icons.auto_stories),
              title: Text('Minha Agenda'),
              onTap: () {
                // Lógica para navegar para a página inicial
              },
            ),
            ListTile(
              leading: Icon(Icons.miscellaneous_services),
              title: Text('Alterar Senha'),
              onTap: () {
                // Lógica para navegar para a página inicial
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Sobre o APP'),
              onTap: () {
                // Lógica para navegar para a página inicial
              },
            ),
            ListTile(
              leading: Icon(Icons.subdirectory_arrow_left),
              title: Text('Sair do APP'),
              onTap: () {
                // Lógica para navegar para a página de configurações
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('CPF: $cpf'),
            Text('Email: $email'),
            Text('Password: $password'),
            Text('Data de Nascimento: $datanasc'),
          ],
        ),
      ),
    );
  }
}
