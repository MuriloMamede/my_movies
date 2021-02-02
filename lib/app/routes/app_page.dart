import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_movies/app/modules/home/bindings/home_binding.dart';
import 'package:my_movies/app/modules/home/views/home_page.dart';
import 'package:my_movies/app/routes/app_routes.dart';

class AppPages {
  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
