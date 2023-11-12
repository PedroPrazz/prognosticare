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
      // Aqui você pode usar a data escolhida e o filtro para buscar os eventos
      print('Data escolhida: ${picked.toIso8601String()} com filtro: $filtro');
      // Atualize seu estado ou faça uma chamada de API para buscar os eventos com o filtro aplicado
    }
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.today),
                  title: Text('Maior que'),
                  onTap: () {
                    Navigator.pop(context);
                    _selectDate(context, 'maior');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.today),
                  title: Text('Igual a'),
                  onTap: () {
                    Navigator.pop(context);
                    _selectDate(context, 'igual');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.today),
                  title: Text('Menor que'),
                  onTap: () {
                    Navigator.pop(context);
                    _selectDate(context, 'menor');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () => _showFilterOptions(context),
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
