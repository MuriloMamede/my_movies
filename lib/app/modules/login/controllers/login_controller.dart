import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_movies/app/data/model/user_model.dart';
import 'package:my_movies/app/data/repository/login_repository.dart';
import 'package:my_movies/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final LoginRepository repository = LoginRepository();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController password2TextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();

  void register() async {
    User user = await repository.signUp(User(
        birthDate: DateTime.now(),
        email: emailTextController.text,
        password: passwordTextController.text,
        name: nameTextController.text));

    if (user != null) {
      Get.offAllNamed(Routes.HOME, arguments: user);
    } else {
      Get.defaultDialog(title: 'Ops..', content: Text('Email já cadastrado'));
    }
  }

  void login() async {
    User user = await repository.login(
        emailTextController.text, passwordTextController.text);

    if (user != null) {
      Get.offNamed(Routes.HOME, arguments: user);
    }
  }
}
