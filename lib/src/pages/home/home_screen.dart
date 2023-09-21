import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prognosticare/components/changePassword.dart';
import 'package:prognosticare/components/meuProntuario.dart';
import 'package:prognosticare/src/api/service/getFindbyIDService.dart';
import 'package:prognosticare/src/pages/auth/schedule_list_screen.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/models/pessoa.dart';
import 'package:prognosticare/src/pages/profile/profile_tab.dart';
import 'package:prognosticare/src/pages/profile/profile_tab_dependente.dart';

final storage = FlutterSecureStorage();

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // final AgendamentoProvider _agendamentoProvider = AgendamentoProvider();
  Pessoa? pessoa;
  String? nome;

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
                if (pessoa == null) {
                  pessoa = await GetFindbyIDService.getFindbyID();
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileTabDepentende(),
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
                    builder: (context) => ScheduleListScreen(),
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
}
