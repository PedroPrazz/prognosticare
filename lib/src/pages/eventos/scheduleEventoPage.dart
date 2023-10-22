import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/navBar/CustomBottomNavigationBar.dart';
import 'package:prognosticare/src/pages/eventos/ScheduleEvento.dart';

TextEditingController email = TextEditingController();
TextEditingController _password = TextEditingController();

class ScheduleEventoPage extends StatelessWidget {
  const ScheduleEventoPage({super.key});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de guias
      child: Scaffold(
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
            ScheduleEvento(filtro: 'maior'),
            ScheduleEvento(filtro: 'igual'),
            ScheduleEvento(filtro: 'menor'),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    
    );
  }
}




