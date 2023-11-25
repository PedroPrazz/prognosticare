import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prognosticare/components/dialogs/change_password_dialog.dart';
import 'package:prognosticare/src/api/service/profilesService.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/profilesModel.dart';
import 'package:prognosticare/src/pages/auth/dependents.dart';
import 'package:prognosticare/components/dialogs/prontuario_dialog.dart';
import 'package:prognosticare/src/api/service/findby_id_service.dart';
import 'package:prognosticare/src/pages/auth/info.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/models/pessoa_model.dart';
import 'package:prognosticare/src/pages/eventos/scheduleEventoPage.dart';
import 'package:prognosticare/src/pages/home/perfisRow.dart';
import 'package:prognosticare/src/pages/profile/profile_tab.dart';
import 'package:prognosticare/src/pages/vaccines/vaccination_schedule.dart';
import 'package:prognosticare/src/routes/app_pages.dart';

final storage = FlutterSecureStorage();

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  Pessoa? pessoa;
  String? nome;
  String? tipoResponsavel;
  Profile? profile;
  late List<Profile> storedProfiles;

  @override
  void initState() {
    super.initState();
    _loadNome();
    _loadTipoResponsavel();
  }

  Future<void> _loadNome() async {
    nome = await storage.read(key: 'nome');
    setState(() {});
  }

  Future<void> _loadTipoResponsavel() async {
    tipoResponsavel = await storage.read(key: 'tipoResponsavel');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (tipoResponsavel != null) {
      if (tipoResponsavel == 'true') {
        return _buildResponsavelScreen();
      } else {
        return _buildDependenteScreen();
      }
    } else {
      return Scaffold();
    }
  }

  // Tela Responsável
  Widget _buildResponsavelScreen() {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('TT'),
              ),
              accountName: Text(
                'Bem-vindo $nome',
                style: TextStyle(color: Colors.white),
              ),
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
                  ),
                );
              },
            ),

            //Meu pronturário
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Meu Prontuário'),
              onTap: () {
                ProntuarioDialog().prontuarioDialog(context);
              },
            ),

            //Meus Dependentes
            ListTile(
              leading: const Icon(Icons.emoji_emotions),
              title: const Text('Meus Dependentes'),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListDependents(),
                  ),
                );
              },
            ),

            //Alterar Senha
            ListTile(
              leading: const Icon(Icons.miscellaneous_services),
              title: const Text('Alterar Senha'),
              onTap: () {
                ChangePasswordDialog().updatePassword(context);
              },
            ),

            //Sobre o APP
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre o APP'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoApp(),
                  ),
                );
              },
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
            //Trocar perfil
            ListTile(
              leading: const Icon(Icons.subdirectory_arrow_left),
              title: const Text('Trocar Perfil'),
              onTap: () async {
                String? profileResponsavel =
                    await storage.read(key: 'profileResponsavel');

                if (profileResponsavel != null) {
                  print('Perfil recuperado: $profileResponsavel');
                  Map<String, dynamic> jsonData =
                      json.decode(profileResponsavel);
                  print('JSON decodificado: $jsonData');
                  Profile profileR = Profile.fromJson(jsonData);

                  List<Profile> profiles =
                      await ProfileService.getProfiles(profileR.pessoaId);

                  if (profiles.isNotEmpty) {
                    profiles.add(profileR);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PerfisRow(
                          profiles: profiles,
                        ),
                      ),
                    );
                  } else {
                    print(
                        'Nenhum perfil encontrado para a pessoaId: ${profileR.pessoaId}');
                    Get.offNamed(PagesRoutes.homeRoute);
                  }
                } else {
                  print('Nenhum perfil armazenado.');
                  Get.offNamed(PagesRoutes.homeRoute);
                }
              },
            ),
          ],
        ),
      ),

      // AppBar
      appBar: AppBar(
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        centerTitle: true,
        title: Text("Olá, ${nome?.split(' ')[0]}"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/medical_prescription.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                children: [
                  _buildGridItem(
                    iconData: Icons.person,
                    text: 'Meus Dados',
                    onTap: () async {
                      if (pessoa == null) {
                        pessoa = await GetFindbyIDService.getFindbyID();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileTab(pessoa: pessoa!),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    iconData: Icons.assignment,
                    text: 'Meu Prontuário',
                    onTap: () {
                      ProntuarioDialog().prontuarioDialog(context);
                    },
                  ),
                  _buildGridItem(
                    iconData: Icons.group,
                    text: 'Meus Dependentes',
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListDependents(),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    iconData: Icons.event,
                    text: 'Eventos',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScheduleEventoPage(),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    iconData: Icons.vaccines,
                    text: 'Vacinas',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Vaccination(),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    iconData: Icons.swap_horiz,
                    text: 'Trocar Perfil',
                    onTap: () async {
                      String? profileResponsavel =
                          await storage.read(key: 'profileResponsavel');

                      if (profileResponsavel != null) {
                        print('Perfil recuperado: $profileResponsavel');
                        Map<String, dynamic> jsonData =
                            json.decode(profileResponsavel);
                        print('JSON decodificado: $jsonData');
                        Profile profileR = Profile.fromJson(jsonData);

                        List<Profile> profiles =
                            await ProfileService.getProfiles(profileR.pessoaId);

                        if (profiles.isNotEmpty) {
                          profiles.add(profileR);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PerfisRow(
                                profiles: profiles,
                              ),
                            ),
                          );
                        } else {
                          print(
                              'Nenhum perfil encontrado para a pessoaId: ${profileR.pessoaId}');
                          Get.offNamed(PagesRoutes.homeRoute);
                        }
                      } else {
                        print('Nenhum perfil armazenado.');
                        Get.offNamed(PagesRoutes.homeRoute);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Tela do dependente
  Widget _buildDependenteScreen() {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('TT'),
              ),
              accountName: Text(
                'Bem-vindo $nome',
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: Text(''),
            ),

            //Meu pronturário
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Meu Prontuário'),
              onTap: () {
                ProntuarioDialog().prontuarioDialog(context);
              },
            ),

            //Sobre o APP
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre o APP'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoApp(),
                  ),
                );
              },
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
            ListTile(
              leading: const Icon(Icons.subdirectory_arrow_left),
              title: const Text('Trocar Perfil'),
              onTap: () async {
                String? profileResponsavel =
                    await storage.read(key: 'profileResponsavel');

                if (profileResponsavel != null) {
                  print('Perfil recuperado: $profileResponsavel');
                  Map<String, dynamic> jsonData =
                      json.decode(profileResponsavel);
                  print('JSON decodificado: $jsonData');
                  Profile profileR = Profile.fromJson(jsonData);

                  List<Profile> profiles =
                      await ProfileService.getProfiles(profileR.pessoaId);

                  if (profiles.isNotEmpty) {
                    profiles.add(profileR);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PerfisRow(
                          profiles: profiles,
                        ),
                      ),
                    );
                  } else {
                    print(
                        'Nenhum perfil encontrado para a pessoaId: ${profileR.pessoaId}');
                    Get.offNamed(PagesRoutes.homeRoute);
                  }
                } else {
                  print('Nenhum perfil armazenado.');
                  Get.offNamed(PagesRoutes.homeRoute);
                }
              },
            ),
          ],
        ),
      ),

      // AppBar
      appBar: AppBar(
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        centerTitle: true,
        title: Text("Olá, ${nome?.split(' ')[0]}"),
        actions: [
          IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/medical_prescription.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                children: [
                  _buildGridItem(
                    iconData: Icons.person,
                    text: 'Meus Dados',
                    onTap: () async {
                      if (pessoa == null) {
                        pessoa = await GetFindbyIDService.getFindbyID();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileTab(pessoa: pessoa!),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    iconData: Icons.event,
                    text: 'Eventos',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScheduleEventoPage(),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    iconData: Icons.vaccines,
                    text: 'Vacinas',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Vaccination(),
                        ),
                      );
                    },
                  ),
                  _buildGridItem(
                    iconData: Icons.swap_horiz,
                    text: 'Trocar Perfil',
                    onTap: () async {
                      String? profileResponsavel =
                          await storage.read(key: 'profileResponsavel');

                      if (profileResponsavel != null) {
                        print('Perfil recuperado: $profileResponsavel');
                        Map<String, dynamic> jsonData =
                            json.decode(profileResponsavel);
                        print('JSON decodificado: $jsonData');
                        Profile profileR = Profile.fromJson(jsonData);

                        List<Profile> profiles =
                            await ProfileService.getProfiles(profileR.pessoaId);

                        if (profiles.isNotEmpty) {
                          profiles.add(profileR);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PerfisRow(
                                profiles: profiles,
                              ),
                            ),
                          );
                        } else {
                          print(
                              'Nenhum perfil encontrado para a pessoaId: ${profileR.pessoaId}');
                          Get.offNamed(PagesRoutes.homeRoute);
                        }
                      } else {
                        print('Nenhum perfil armazenado.');
                        Get.offNamed(PagesRoutes.homeRoute);
                      }
                    },
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

Widget _buildGridItem(
    {required IconData iconData,
    required String text,
    required VoidCallback onTap}) {
  return Card(
    color: CustomColors.customSwatchColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: CustomColors.customSwatchColor.shade200,
        width: 2.0,
      ),
    ),
    elevation: 2.0,
    child: InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(height: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
