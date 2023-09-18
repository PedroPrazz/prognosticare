import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:prognosticare/components/dialog.dart';
import 'package:prognosticare/src/pages_routes/app_pages.dart';

List dependente_id = [];

class MeusDependentes extends StatelessWidget {
  final String? id;
  final String? cpf;
  final String? email;
  final String? password;
  final String? datanasc;

  MeusDependentes(
      {this.id, this.cpf, this.email, this.password, this.datanasc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        title: Text('Meus Dependentes'),
        backgroundColor: Color.fromRGBO(255, 143, 171, 1),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                Container(
                  height: 50,
                ),
                Container(
                  height: 250,
                  child: ListView.builder(
                      itemCount: dependente_id.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(dependente_id[index]),
                          trailing: IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              (() {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Confirmacao();
                                    });
                              });
                            },
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(PagesRoutes.profileTabDependenteRoute);
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromRGBO(255, 143, 171, 1),
      ),
    );
  }
}
