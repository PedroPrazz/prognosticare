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
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        ListTile(
          title: Text('Criança'),
          subtitle: Text('Entre 0 e 10 anos'),
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/img-crianca.png'),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VaccineScreen()));
          },
        );
      }),
    );
  }
}
