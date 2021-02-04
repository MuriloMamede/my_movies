import 'package:get/get.dart';

class OptionsController extends GetxController {
//final MyRepository repository;

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
