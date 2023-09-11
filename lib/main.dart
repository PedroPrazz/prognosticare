import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/pages_routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: CustomColors.customSwatchColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: PagesRoutes.signInRoute,
      getPages: AppPages.pages,
    );
  }
}


// VOU VERIFICAR A ALTERAÇÃO DA MAIN POSTERIOMENTE

// import 'package:flutter/material.dart';
// import 'package:prognosticare/src/auth/sign_in_screen.dart';
// import 'package:prognosticare/src/auth/splash_page.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.pink,
//       ),
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/splash',
//       routes: {
//         '/splash': (context) => SplashPage(),
//         '/login': (context) => SignInScreen(),
//       },
//     ),
//   );
// }

