import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prognosticare/components/dialogs/change_password_dialog.dart';
import 'package:prognosticare/src/navBar/CustomBottomNavigationBar.dart';
import 'package:prognosticare/src/pages/auth/dependents.dart';
import 'package:prognosticare/components/dialogs/prontuario_dialog.dart';
import 'package:prognosticare/src/api/service/findby_id_service.dart';
import 'package:prognosticare/src/pages/auth/info.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/models/pessoa_model.dart';
import 'package:prognosticare/src/pages/profile/profile_tab.dart';
import 'package:prognosticare/src/pages/schedule/my_schedule_screen.dart';

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
        child: ListView(
          children: [
            // 1. Imagem Tema Saúde
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/medical_prescription.png'), // Coloque o caminho da sua imagem aqui
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 20),

            // 2. Três botões
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Botão 1')),
                ElevatedButton(onPressed: () {}, child: Text('Botão 2')),
                ElevatedButton(onPressed: () {}, child: Text('Botão 3')),
              ],
            ),
            SizedBox(height: 20),

            // 3. Carrossel 1
            Container(
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    5, // Aqui você pode definir o número de itens que quer exibir no carrossel
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Image.asset(
                        'path_da_imagem_$index.jpg'), // Aqui você pode definir os itens do carrossel
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // 4. Carrossel 2
            Container(
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    5, // Aqui você pode definir o número de itens que quer exibir no carrossel
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      onTap: () {
                        // Aqui você pode definir o que acontece ao tocar em uma imagem do carrossel, como ir para a tela de vacinas filtrado com base na imagem
                      },
                      child: Image.asset('path_da_imagem_vacina_$index.png'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // actions: [],
      // title: const Text('PrognostiCare'),
      // backgroundColor: CustomColors.customSwatchColor,
      // foregroundColor: Colors.white,
      // centerTitle: true,

      //navbar
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
