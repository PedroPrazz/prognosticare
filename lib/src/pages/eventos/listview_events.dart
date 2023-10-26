import 'package:flutter/material.dart';
import 'package:prognosticare/src/config/custom_colors.dart';

Widget buildEventList(String title) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: CustomColors.customSwatchColor.shade100,
    ),
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount:
                events.length, // Substitua 'events' pela sua lista de eventos
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(events[index].patientName),
                subtitle: Text(events[index].description),
                trailing: Icon(Icons.access_time), // Ícone de relógio
              );
            },
          ),
        ),
      ],
    ),
  );
}

class Event {
  final String patientName;
  final String description;

  Event(this.patientName, this.description);
}

List<Event> events = [
  Event("Paciente 1", "Descrição do evento 1"),
  Event("Paciente 2", "Descrição do evento 2"),
  Event("Paciente 3", "Descrição do evento 3"),
  // Adicione mais eventos conforme necessário
];
