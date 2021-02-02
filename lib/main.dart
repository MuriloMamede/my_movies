import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_page.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Meus Filmes',
    debugShowCheckedModeBanner: true,
    getPages: AppPages.routes,
    initialRoute: Routes.HOME,
    theme: appThemeData,
  ));
}
