import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_movies/app/modules/home/bindings/home_binding.dart';
import 'package:my_movies/app/modules/home/views/home_page.dart';
import 'package:my_movies/app/modules/login/bindings/login_binding.dart';
import 'package:my_movies/app/modules/login/views/login_page.dart';
import 'package:my_movies/app/modules/options/bindings/options_binding.dart';
import 'package:my_movies/app/modules/options/views/options_page.dart';
import 'package:my_movies/app/modules/search/bindings/search_binding.dart';
import 'package:my_movies/app/modules/search/views/search_page.dart';
import 'package:my_movies/app/modules/singup/bindings/signup_binding.dart';
import 'package:my_movies/app/modules/singup/views/signup_page.dart';
import 'package:my_movies/app/routes/app_routes.dart';

class AppPages {
  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.OPTIONS,
      page: () => OptionsPage(),
      binding: OptionsBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),
  ];
}
