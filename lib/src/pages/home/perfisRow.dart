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

  Future<void> resetarDadosDoUsuarioENavegar(Profile perfilSelecionado) async {
    // Redefinir as informações do usuário
    String? idPessoa = perfilSelecionado.pessoaId;
    String? nome = perfilSelecionado.nome;
    bool? tipoResponsavel = perfilSelecionado.tipoResponsavel;

    // Atualize os valores armazenados
    await storage.write(key: 'user_id', value: idPessoa);
    await storage.write(key: 'nome', value: nome);
    await storage.write(key: 'tipoResponsavel', value: tipoResponsavel.toString());

    // Navegue para a homeRoute
    Get.offNamed(PagesRoutes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecione um Perfil')),
      body: Container(
        color: CustomColors.customSwatchColor.shade100,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (var profile in profiles)
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              resetarDadosDoUsuarioENavegar(profile);
                            },
                            child: PerfilWidget(nome: profile.nome!),
                          ),
                        ),
                    ],
                  ),
                ],
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
