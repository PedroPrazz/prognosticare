import 'package:flutter/material.dart';
import 'package:prognosticare/src/pages/home/today.dart';
import 'package:prognosticare/src/pages/home/tomorrow.dart';
import 'package:prognosticare/src/pages/home/yesterday.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget currentColumn = Today();

  void switchToToday() {
    setState(() {
      currentColumn = Today();
    });
  }

  void switchToYesterday() {
    setState(() {
      currentColumn = Yesterday();
    });
  }

  void switchToTomorrow() {
    setState(() {
      currentColumn = Tomorrow();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: switchToYesterday,
              child: Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    "Eventos de Ontem",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: InkWell(
              onTap: switchToToday,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "Eventos de Hoje",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: switchToTomorrow,
              child: Container(
                color: Colors.green,
                child: Center(
                  child: Text(
                    "Eventos de Amanhã",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
