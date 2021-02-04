import 'package:get/get.dart';
import 'package:my_movies/app/modules/options/controllers/options_controller.dart';

class OptionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OptionsController>(
      () => OptionsController(),
    );
  }
}
