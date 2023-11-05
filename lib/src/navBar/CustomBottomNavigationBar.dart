import 'package:flutter/material.dart';
import 'package:prognosticare/components/dialogs/prontuario_dialog.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/pages/eventos/scheduleEventoPage.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';
import 'package:prognosticare/src/pages/vaccines/vaccination_schedule.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      color: CustomColors.customSwatchColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            },
            tooltip: 'Home',
            icon: const Icon(Icons.home),
            iconSize: 30,
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Vaccination()),
                (route) => false,
              );
            },
            tooltip: 'Vacinas',
            icon: const Icon(Icons.vaccines),
            iconSize: 30,
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              ProntuarioDialog().prontuarioDialog(context);
            },
            tooltip: 'Prontuário',
            icon: const Icon(Icons.task),
            iconSize: 30,
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScheduleEventoPage(),
                ),
              );
            },
            tooltip: 'Eventos',
            icon: const Icon(Icons.event),
            iconSize: 30,
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScheduleEventoPage(),
                ),
              );
            },
            tooltip: 'Eventos',
            icon: const Icon(Icons.help_outline_outlined),
            iconSize: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
