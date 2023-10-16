import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prognosticare/components/dialogs/change_password_dialog.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/pages/auth/dependents.dart';
import 'package:prognosticare/components/dialogs/prontuario_dialog.dart';
import 'package:prognosticare/src/api/service/findby_id_service.dart';
import 'package:prognosticare/src/pages/auth/info.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/models/pessoa_model.dart';
import 'package:prognosticare/src/pages/profile/profile_tab.dart';
import 'package:prognosticare/src/pages/schedule/my_schedule_screen.dart';
import 'package:prognosticare/src/pages/vaccines/vaccination_schedule.dart';
import 'package:prognosticare/src/pages/vaccine/vaccine_screen.dart';

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

  int _selectIndex = 0;
  int contador = 0;

  @override
  void initState() {
    super.initState();
    _loadNome();
  }

  Future<void> _loadNome() async {
    nome = await storage.read(key: 'nome');
    setState(() {}); // Atualiza o estado para refletir o nome carregado.
  }

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
                    builder: (context) => MySchedule(),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        title: const Text('PrognostiCare'),
        backgroundColor: CustomColors.customSwatchColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      //navbar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColors.customSwatchColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        currentIndex: _selectIndex,
        onTap: (index) {
          setState(() {
            PageController().animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.ease);
            _selectIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.vaccines),
            label: 'Vacinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Prontuário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Dependentes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Agenda',
          ),
        ],
      ),
    );
  }
}
