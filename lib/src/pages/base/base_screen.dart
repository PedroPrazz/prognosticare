import 'package:flutter/material.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({Key? key}) : super(key: key);


  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
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
                //  Pessoa pessoa = await GetFindbyIDService.getFindbyID();
                //  print(GetFindbyIDService.getFindbyID());
                //  if (pessoa == null){
                //   print('Não tem pessoa Cadastrada');
                //  }else{
                //   Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile(pessoa: pessoa)));
                //  }
              },
            ),

            //Meu pronturário
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Meu Prontuário'),
              onTap: () {},
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
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
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
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen()), (route) => false);
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
        child: Text('Você não possuí eventos'),
      ),
    );
  }
}
