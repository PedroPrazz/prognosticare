import 'package:flutter/material.dart';
import 'package:prognosticare/src/auth/sign_in_screen.dart';
import 'package:prognosticare/src/auth/splash_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashPage(),
        '/login': (context) => SignInScreen(),
      },
    ),
  );
}
