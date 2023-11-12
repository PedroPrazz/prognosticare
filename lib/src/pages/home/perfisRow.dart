import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/profilesModel.dart';
import 'package:prognosticare/src/routes/app_pages.dart';

final storage = FlutterSecureStorage();

class PerfisRow extends StatelessWidget {
  final List<Profile> profiles;

  PerfisRow({required this.profiles});

  List<Profile> ordenarPerfis(List<Profile> profiles) {
    List<Profile> sortedProfiles = List<Profile>.from(profiles);

    sortedProfiles.sort((a, b) {
      if (a.tipoResponsavel! && !b.tipoResponsavel!) {
        return -1;
      } else if (!a.tipoResponsavel! && b.tipoResponsavel!) {
        return 1;
      }
      return a.nome?.compareTo(b.nome!) ?? 0;
    });
    return sortedProfiles;
  }

  Future<void> resetarDadosDoUsuarioENavegar(Profile perfilSelecionado) async {
    String? idPessoa = perfilSelecionado.pessoaId;
    String? nome = perfilSelecionado.nome;
    bool? tipoResponsavel = perfilSelecionado.tipoResponsavel;

    await storage.write(key: 'user_id', value: idPessoa);
    await storage.write(key: 'nome', value: nome);
    await storage.write(key: 'tipoResponsavel', value: tipoResponsavel.toString());

    Get.offNamed(PagesRoutes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    List<Profile> sortedProfiles = ordenarPerfis(profiles);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Selecione um Perfil'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Card do Responsável
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          resetarDadosDoUsuarioENavegar(sortedProfiles.first);
                        },
                        child: Card(
                          margin: EdgeInsets.only(bottom: 20),
                          color: CustomColors.customSwatchColor.shade900,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                Text(
                                  sortedProfiles.first.nome!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Seus Dependentes',
                        style: TextStyle(
                          color: CustomColors.customContrastColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Cards dos Dependentes usando Wrap
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.0,
                      children: sortedProfiles
                          .skip(1)
                          .map((profile) => GestureDetector(
                                onTap: () {
                                  resetarDadosDoUsuarioENavegar(profile);
                                },
                                child: SizedBox(
                                  width: 150,
                                  child: Card(
                                    color: CustomColors.customContrastColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.group,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            profile.nome!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
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
      color: CustomColors.customContrastColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(nome, style: TextStyle(fontSize: 24, color: Colors.white)),
        ],
      ),
    );
  }
}
