import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/app_setting.dart';

import 'config/theme/app_colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/localization_service.dart';

void main() async {
  await LocalizationService.initialize();

  runZonedGuarded(() {
    runApp(MyApp());
  }, (e, s) {
    // Log Firebase crashlytics
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppSetting.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: AppColor.backgroundColor,
      ),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      initialRoute: Routes.SPLASH_PAGE,
      getPages: AppPages.pages,
    );
  }
}
