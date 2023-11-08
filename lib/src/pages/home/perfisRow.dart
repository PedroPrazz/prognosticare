import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart'; // Importe o pacote Get
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/profilesModel.dart';
import 'package:prognosticare/src/routes/app_pages.dart';

final storage = FlutterSecureStorage();

class PerfisRow extends StatelessWidget {
  final List<Profile> profiles;

  PerfisRow({required this.profiles});

  // Função para ordenar os perfis
  List<Profile> ordenarPerfis(List<Profile> profiles) {
    List<Profile> sortedProfiles = List<Profile>.from(profiles);

    sortedProfiles.sort((a, b) {
      if (a.tipoResponsavel! && !b.tipoResponsavel!) {
        return -1;
      } else if (!a.tipoResponsavel! && b.tipoResponsavel!) {
        return 1;
      }
      // Se ambos forem responsáveis ou dependentes, ordena alfabeticamente
      return a.nome?.compareTo(b.nome!) ?? 0;
    });
    return sortedProfiles;
  }

  Future<void> resetarDadosDoUsuarioENavegar(Profile perfilSelecionado) async {
    // Redefinir as informações do usuário
    String? idPessoa = perfilSelecionado.pessoaId;
    String? nome = perfilSelecionado.nome;
    bool? tipoResponsavel = perfilSelecionado.tipoResponsavel;

    // Atualize os valores armazenados
    await storage.write(key: 'user_id', value: idPessoa);
    await storage.write(key: 'nome', value: nome);
    await storage.write(
        key: 'tipoResponsavel', value: tipoResponsavel.toString());

    // Navegue para a homeRoute
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
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: sortedProfiles.map((profile) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          resetarDadosDoUsuarioENavegar(profile);
                        },
                        child: Card(
                            color: Colors.blue.shade200,
                            child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      profile.tipoResponsavel!
                                          ? Icons.person
                                          : Icons.group,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    Text(profile.nome!,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                  ],
                                ))),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // Logo com tamanho fixo
            Container(
              height: 250, // Defina a altura desejada para a logo
              width:
                  double.infinity, // A logo ocupará toda a largura disponível
              child: Image.asset('assets/images/logo.png',
                  fit: BoxFit.contain), // Substitua pelo caminho do seu logo
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
