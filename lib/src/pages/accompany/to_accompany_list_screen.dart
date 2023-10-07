import 'package:flutter/material.dart';
import 'package:prognosticare/src/api/service/to_accompany_list_service.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/to_accompany_model.dart';
import 'package:prognosticare/src/pages/accompany/to_accompany_screen.dart';

class ToAccompanyListScreen extends StatefulWidget {
  const ToAccompanyListScreen({Key? key}) : super(key: key);

  @override
  State<ToAccompanyListScreen> createState() => _ToAccompanyListScreenState();
}

class _ToAccompanyListScreenState extends State<ToAccompanyListScreen> {
  late Future<List<Accompany>> accompanyFuture;

  @override
  void initState() {
    super.initState();
    accompanyFuture = ToAccompanyListService.getAccompanyList();
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
                return ListTile(
                  title: Text(toaccompany.medicacao!),
                  subtitle: Text(toaccompany.prescricaoMedica!),
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {},
                  ),
                  onTap: () {},
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
