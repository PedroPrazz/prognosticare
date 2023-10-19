import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  const Today({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Eventos de Hoje",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${event.patientName}"),
                          Text("Descrição: ${event.description}"),
                          Text("Tipo: ${event.eventType}"),
                        ],
                      ),
                    ),
                    Icon(Icons.access_time, size: 35),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String patientName;
  final String description;
  final String eventType;

  Event(this.patientName, this.description, this.eventType);
}

final List<Event> events = [
  Event("João", "Exame de sangue", "Exame"),
  Event("Maria", "Consulta de rotina", "Consulta"),
  Event("Pedro", "Medicação diária", "Medicação"),
  Event("João", "Exame de sangue", "Exame"),
  Event("Maria", "Consulta de rotina", "Consulta"),
  Event("Pedro", "Medicação diária", "Medicação"),
  Event("João", "Exame de sangue", "Exame"),
  Event("Maria", "Consulta de rotina", "Consulta"),
  Event("Pedro", "Medicação diária", "Medicação"),
  Event("João", "Exame de sangue", "Exame"),
  Event("Maria", "Consulta de rotina", "Consulta"),
  Event("Pedro", "Medicação diária", "Medicação"),
  Event("João", "Exame de sangue", "Exame"),
  Event("Maria", "Consulta de rotina", "Consulta"),
  Event("Pedro", "Medicação diária", "Medicação"),
];
