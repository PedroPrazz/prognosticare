import 'package:flutter/material.dart';
import 'package:prognosticare/src/models/vaccines.dart';

class VacinasList extends StatefulWidget {

  @override
  State<VacinasList> createState() => _VacinasList();
}

class _VacinasList extends State<VacinasList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        backgroundColor: Color.fromRGBO(111, 194, 150, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: Vacinas[0]['users'].length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
              },
              leading: Image.network(Vacinas[0]['crianca'][index]['nome']),
              title: Text(Vacinas[0]['crianca'][index]['descricao']),
              subtitle: Text(Vacinas[0]['crianca'][index]['dose']),
            );
          },
        ),
      ),
    );
  }
}