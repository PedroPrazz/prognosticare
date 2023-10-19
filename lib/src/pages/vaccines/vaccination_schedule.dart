import 'package:flutter/material.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/vaccines.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';

class Vaccination extends StatefulWidget {
  @override
  _VaccinationState createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  String selectedGroup =
      "Vacinas para Crianças"; // Inicialmente selecionado como "Vacina para Crianças"

  void _updateSelectedGroup(String? group) {
    if (group != null) {
      setState(() {
        selectedGroup = group;
      });
    }
  }

  List<Map<String, dynamic>> getVaccineList() {
    switch (selectedGroup) {
      case "Vacinas para Crianças":
        return Vacinas[0]['crianca'];
      case "Vacinas para Adolescentes":
        return Vacinas[0]['adolescente'];
      case "Vacinas para Adultos":
        return Vacinas[0]['adulto'];
      case "Vacinas para Gestantes":
        return Vacinas[0]['gestante'];
      case "Vacinas para Idosos":
        return Vacinas[0]['idoso'];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendário de Vacinas'),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 300,
                child: DropdownButtonFormField<String>(
                  focusColor: Colors.white,
                  decoration: InputDecoration(
                    hoverColor: Colors.blue,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: CustomColors.customSwatchColor,
                      ),
                    ),
                  ),
                  value: selectedGroup,
                  items: [
                    "Vacinas para Crianças",
                    "Vacinas para Adolescentes",
                    "Vacinas para Adultos",
                    "Vacinas para Gestantes",
                    "Vacinas para Idosos",
                  ].map((String group) {
                    return DropdownMenuItem<String>(
                      value: group,
                      child: Row(
                        children: [
                          Icon(Icons.vaccines,
                              color: CustomColors.customSwatchColor),
                          SizedBox(width: 10),
                          Text(
                            group,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: _updateSelectedGroup,
                ),
              ),
              Container(
                width: size.width,
                height: size.height,
                child: ListView.builder(
                  itemCount: getVaccineList().length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(getVaccineList()[index]['nome']),
                      subtitle: Text(getVaccineList()[index]['descricao']),
                      trailing: Text(getVaccineList()[index]['dose']),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
