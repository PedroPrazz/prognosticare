import 'package:flutter/material.dart';
import 'package:prognosticare/src/auth/sign_in_screen.dart';
import 'package:prognosticare/src/config/custom_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: CustomColors.customSwatchColor,
      ),
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

