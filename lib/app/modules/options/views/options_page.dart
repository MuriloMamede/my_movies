import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies/app/modules/options/controllers/options_controller.dart';

class OptionsPage extends GetView<OptionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OptionsPage')),
      body: Container(
        child: GetX<OptionsController>(
            init: OptionsController(),
            builder: (_) {
              return Container();
            }),
      ),
    );
  }
}
