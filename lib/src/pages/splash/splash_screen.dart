import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prognosticare/src/pages_routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then(
      (_) => {
        Get.offNamed(PagesRoutes.signInRoute),
      },
    );
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
