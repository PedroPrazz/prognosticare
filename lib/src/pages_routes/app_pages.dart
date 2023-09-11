import 'package:get/get.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/auth/sign_up_screen.dart';
import 'package:prognosticare/src/pages/base/base_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => SignInScreen(),
      name: PagesRoutes.signInRoute,
    ),
    GetPage(
      page: () => SignUpScreen(),
      name: PagesRoutes.signUpRoute,
    ),
    GetPage(
      page: () => BaseScreen(),
      name: PagesRoutes.baseRoute,
    ),
  ];
}

abstract class PagesRoutes {
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String baseRoute = '/';
}
