import 'package:get/get.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/auth/sign_up_screen.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';
import 'package:prognosticare/src/pages/splash/splash_screen.dart';
import 'package:prognosticare/src/pages/vaccines/vaccination_schedule.dart';

abstract class AppPages {
  static final pages = <GetPage>[
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
    GetPage(
      page: () => Vaccination(),
      name: PagesRoutes.vaccination,
    ),
    
  ];
}

abstract class PagesRoutes {
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String vaccination = '/vaccination';
  static const String homeRoute = '/';

  
}
