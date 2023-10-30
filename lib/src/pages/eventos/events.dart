import 'package:flutter/material.dart';
import 'package:prognosticare/src/config/custom_colors.dart';

TextEditingController email = TextEditingController();
TextEditingController _password = TextEditingController();

class EventoPage extends StatelessWidget {
  const EventoPage({super.key});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de guias
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text('Eventos'),
          backgroundColor: CustomColors.customSwatchColor,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Próximos'),
              Tab(text: 'Em Andamento'),
              Tab(text: 'Últimos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //HomePage(),
           // ProfilePage(),
           // SettingsPage(),
          ],
        ),
      ),
    );
  }
}




