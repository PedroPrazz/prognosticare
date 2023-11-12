import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:prognosticare/components/dialogs/change_password_dialog.dart';
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
import 'package:prognosticare/src/pages/schedule/my_schedule_screen.dart';
import 'package:prognosticare/src/pages/vaccines/vaccination_schedule.dart';

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

            //Minha Agenda
            ListTile(
              leading: const Icon(Icons.auto_stories),
              title: const Text('Minha Agenda'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ToAccompanyScreenEvent(),
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
                    iconData: Icons.healing,
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PerfisRow(profiles: []),
                        ),
                      );
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
                    iconData: Icons.healing,
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PerfisRow(profiles: []),
                        ),
                      );
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
        color: CustomColors.customContrastColor,
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
