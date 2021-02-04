import 'package:get/get.dart';
import 'package:my_movies/app/modules/login/controllers/login_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
