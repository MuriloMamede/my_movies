import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_movies/app/data/model/user_model.dart';

class OptionsController extends GetxController {
  final data = GetStorage();
  Map get userMap => data.read("user");
  User get user => User.fromMap(userMap);
  String get birthDate =>
      DateFormat(DateFormat.YEAR_MONTH_DAY, "pt_Br").format(user.birthDate);
  @override
  void onInit() {
    print(user.email);
    super.onInit();
  }
}
