import 'package:flutter/material.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/pages/eventos/ScheduleEvento.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';

class ScheduleEventoPage extends StatelessWidget {
  const ScheduleEventoPage({super.key});

  Future<void> _selectDate(BuildContext context, String filtro) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      print('Data escolhida: ${picked.toIso8601String()} com filtro: $filtro');
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedType = 'Todos'; // Valor inicial
    List<String> eventTypes = ['Todos', 'Consultas', 'Exames', 'Vacinas'];
    DateTime selectedDate = DateTime.now();

    return DefaultTabController(
      length: 3, // Número de guias
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.white,
          title: Text('Eventos'),
          backgroundColor: CustomColors.customSwatchColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      width: 200,
                      height: 300,
                      child: Column(
                        children: <Widget>[
                          Text('Filtrar por Tipo e Data'),
                          DropdownButton<String>(
                            value: selectedType,
                            onChanged: (String? newValue) {
                              selectedType = newValue!;
                            },
                            items: eventTypes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          // DatePicker para selecionar a data
                          ElevatedButton(
                            child: Text("Selecionar Data"),
                            onPressed: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                              );
                              if (picked != null && picked != selectedDate) {
                                selectedDate = picked;
                              }
                            },
                          ),
                          ElevatedButton(
                            child: Text('Aplicar Filtro'),
                            onPressed: () {
                              Navigator.pop(context);
                              // Aplicar o filtro
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blue.withOpacity(0.5),
            indicatorColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 20),
            unselectedLabelStyle: TextStyle(fontSize: 15),
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
      ),
    );
  }
}
