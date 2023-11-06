import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prognosticare/components/dialogs/change_password_dialog.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/models/profilesModel.dart';
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
  String? tipoResponsavel;
  Profile? profile;

  final List<String> imageNames = [
    'img-adolescente.png',
    'img-adulto.png',
    'img-crianca.png',
    'img-gestante.png',
    'img-idoso.png',
  ];

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
      return Scaffold(
        appBar: AppBar(
          title: Text('Erro'),
        ),
        body: Center(
          child: Text('O tipo de perfil não foi definido corretamente.'),
        ),
      );
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
        child: ListView(
          children: [
            // 1. Imagem Tema Saúde
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
            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: CustomColors.customContrastColor, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Label
                  Padding(
                    padding: EdgeInsets.all(double.parse('10.0')),
                    child: Text(
                      'INFORMAÇÕES',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          CupertinoIcons.heart_solid,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.medical_information,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.medication,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: CustomColors.customContrastColor, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageNames.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset('assets/images/${imageNames[index]}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      //navbar
      bottomNavigationBar: CustomBottomNavigationBar(),
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
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    CupertinoIcons.heart_solid,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.medical_information,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.medication,
                    color: Colors.white,
                    size: 30,
                  ),
                )
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
                        'assets/images/covid$index.png'), // Aqui você pode definir os itens do carrossel
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
                    imageNames.length, // Usa a quantidade de nomes na lista
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      onTap: () {
                        // Aqui você pode definir o que acontece ao tocar em uma imagem do carrossel
                      },
                      child: Image.asset(
                          'assets/images/${imageNames[index]}'), // Usa os nomes da lista
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      //navbar
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
