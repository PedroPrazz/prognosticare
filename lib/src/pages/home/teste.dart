import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perfis'),
        ),
        body: Center(
          child: PerfisRow(),
        ),
      ),
    );
  }
}

class PerfisRow extends StatefulWidget {
  @override
  _PerfisRowState createState() => _PerfisRowState();
}

class _PerfisRowState extends State<PerfisRow> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i <= contador && i < 4; i++)
            Padding(
              padding: EdgeInsets.all(8.0), // Adicione margem de 8 pixels
              child: PerfilWidget(nome: (i == 0 ? "X" : i.toString())),
            ),
          if (contador < 4)
            IconButton(
              icon: Icon(Icons.add, size: 60, color: Colors.green),
              onPressed: () {
                setState(() {
                  contador++;
                });
              },
            ),
        ],
      ),
    );
  }
}

class PerfilWidget extends StatelessWidget {
  final String nome;

  PerfilWidget({required this.nome});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(nome, style: TextStyle(fontSize: 24, color: Colors.white)),
        ],
      ),
    );
  }
}
