import 'package:get/get.dart';
import '../bindings/login_binding.dart';
import '../views/pages/login/login_page.dart';
import '../views/pages/register/register_page.dart';
import '../views/pages/splash/splash_page.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH_PAGE,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.LOGIN_IN_PAGE,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_PAGE,
      page: () => const RegisterPage(),
    )
  ];
}
