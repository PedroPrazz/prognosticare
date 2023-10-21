import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/accompany_service.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';
import 'package:prognosticare/src/pages/accompany/to_accompany_screen.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';

class ToAccompanyListScreen extends StatefulWidget {
  ToAccompanyListScreen({Key? key}) : super(key: key);

  @override
  State<ToAccompanyListScreen> createState() => _ToAccompanyListScreenState();
}

class _ToAccompanyListScreenState extends State<ToAccompanyListScreen> {
  late Future<List<Accompany>> accompanyFuture;
  bool isAcompanhamentoConfirmado = false;

  @override
  void initState() {
    super.initState();
    accompanyFuture = AccompanyService.getAccompanyList();
  }

  Future<void> _confirmarAcompanhamento(Accompany accompany) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Agendamento'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você deseja confirmar o agendamento:'),
                Text(accompany.medicacao),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                setState(() {
                  isAcompanhamentoConfirmado = false;
                  accompany.statusEvento = "FINALIZADO";
                  AccompanyService.updateStatus(accompany);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Acompanhamentos'),
        centerTitle: true,
        backgroundColor: CustomColors.customSwatchColor,
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
      body: FutureBuilder<List<Accompany>>(
        future: accompanyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar a lista de acompanhamentos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum acompanhamento encontrado'));
          } else {
            final accompany = snapshot.data!;
            return ListView.builder(
              itemCount: accompany.length,
              itemBuilder: (context, index) {
                final toaccompany = accompany[index];
                Color statusColor = toaccompany.statusEvento == "ABERTO" ? Colors.green : Colors.red; // Define a cor com base no status
                isAcompanhamentoConfirmado = toaccompany.statusEvento == "FINALIZADO";
                return ListTile(
                  title: Text(toaccompany.medicacao + " " + toaccompany.prescricaoMedica),
                  subtitle: Text(toaccompany.statusEvento!, style:  TextStyle(color: statusColor),),
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (c) {
                          return ToAccompanyScreen(
                            accompany: toaccompany,
                            isEditing: true, // Modo de edição ativado
                          );
                        },
                      ));
                    },
                  ),
                  trailing: isAcompanhamentoConfirmado
                    ? Icon(Icons.check_circle, color: Colors.green) // Agendamento realizado
                    : Icon(Icons.radio_button_unchecked),  // Agendamento não realizado
                  onTap: () {
                    _confirmarAcompanhamento(toaccompany);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (c) {
              return ToAccompanyScreen();
            },
          ));
        },
        label: Text(
          'ACOMPANHAR',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
