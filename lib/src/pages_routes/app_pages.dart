import 'package:get/get.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/auth/sign_up_screen.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';
import 'package:prognosticare/src/pages/profile/profile_tab_dependente.dart';
import 'package:prognosticare/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => ProfileTabDependente(),
      name: PagesRoutes.profileTabDependenteRoute,
    ),
    GetPage(
      page: () => const SplashScreen(),
      name: PagesRoutes.splashRoute,
    ),
    GetPage(
      page: () => SignInScreen(),
      name: PagesRoutes.signInRoute,
    ),
    GetPage(
      page: () => SignUpScreen(),
      name: PagesRoutes.signUpRoute,
    ),
    GetPage(
      page: () => HomeScreen(),
      name: PagesRoutes.homeRoute,
    ),
  ];
}

abstract class PagesRoutes {
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String profileTabDependenteRoute = '/dependent';
  static const String homeRoute = '/';
}
