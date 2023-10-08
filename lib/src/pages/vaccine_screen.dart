import 'package:flutter/material.dart';
import 'package:prognosticare/src/config/custom_colors.dart';

class VaccineScreen extends StatefulWidget {
  const VaccineScreen({super.key});

  @override
  State<VaccineScreen> createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cartilha de vacinação'),
        backgroundColor: CustomColors.customSwatchColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/img-crianca.png',
            width: 100,
            height: 100,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Criança | Entre 0 e 10 anos',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Image.asset(
            'assets/images/img-adolescente.png',
            width: 100,
            height: 100,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Adolescente | Entre 11 e 19 anos',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Image.asset(
            'assets/images/img-adulto.png',
            width: 100,
            height: 100,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Adulto | Entre 20 e 59 anos',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Image.asset(
            'assets/images/img-gestante.png',
            width: 100,
            height: 100,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Gestante | Periódo gestacional',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Image.asset(
            'assets/images/img-idoso.png',
            width: 100,
            height: 100,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Idoso | 60 anos ou mais',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
