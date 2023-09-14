import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prognosticare/pages-antigas/profile.dart';
import 'package:prognosticare/src/api/service/getFindbyIDService.dart';
import 'package:prognosticare/src/pages/auth/prontuario.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/models/pessoa.dart';
import 'package:prognosticare/src/pages/common_widgets/custom_text_field.dart';
import 'package:prognosticare/src/pages/profile/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  Pessoa? pessoa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menu Lateral
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('TT'),
              ),
              accountName: Text(''),
              accountEmail: Text(''),
            ),

            //Meus Dados
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Meus Dados'),
              onTap: () async {
                if (pessoa == null) {
                  pessoa = await GetFindbyIDService.getFindbyID();
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileTab(pessoa: pessoa!),
                    ));
              },
            ),

            //Meu pronturário
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Meu Prontuário'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Prontuario()));
              },
            ),

            //Meus Dependentes
            ListTile(
              leading: const Icon(Icons.emoji_emotions),
              title: const Text('Meus Dependentes'),
              onTap: () {},
            ),

            //Minha Agenda
            ListTile(
              leading: const Icon(Icons.auto_stories),
              title: const Text('Minha Agenda'),
              onTap: () {},
            ),

            //Alterar Senha
            ListTile(
              leading: const Icon(Icons.miscellaneous_services),
              title: const Text('Alterar Senha'),
              onTap: () {
                updatePassword();
              },
            ),

            //Sobre o APP
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre o APP'),
              onTap: () {},
            ),

            //Sair do APP
            ListTile(
              leading: const Icon(Icons.subdirectory_arrow_left),
              title: const Text('Sair do APP'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),

      // AppBar
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        title: const Text('PrognostiCare'),
        backgroundColor: const Color.fromRGBO(255, 143, 171, 1),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('Você não possuí eventos!', style: TextStyle(fontSize: 20)),
      ),
      //
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Agendamentos'),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Acompanhamentos'),
                ),
              ),
            ],
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color.fromRGBO(255, 143, 171, 1),
      ),
    );
  }

//Dialog Alterar Senha
  Future<bool?> updatePassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Titulo
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Alteração de senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // // Senha atual
                    // const CustomTextField(
                    //   isSecret: true,
                    //   icon: Icons.lock,
                    //   label: 'Senha Atual',
                    // ),

                    // Nova senha
                    const CustomTextField(
                      isSecret: true,
                      icon: Icons.lock_outlined,
                      label: 'Nova Senha',
                    ),

                    // Confirmar senha
                    const CustomTextField(
                      isSecret: true,
                      icon: Icons.lock_outlined,
                      label: 'Confirmar nova Senha',
                    ),

                    //Botão de confirmação
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Alterar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
