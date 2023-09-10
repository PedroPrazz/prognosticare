import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplahPageState();
}

class _SplahPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) => {
          Navigator.of(context).pushReplacementNamed('/login'),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Substitua pelo caminho correto da imagem do logotipo.
              width: 250, // Ajuste o tamanho conforme necessário.
              height: 250,
            ),
            SizedBox(
                height:
                    30), // Espaçamento entre a imagem e o indicador de progresso.
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
            ),
          ],
        ),
      ),
    );
  }
}
