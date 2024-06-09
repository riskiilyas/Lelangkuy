import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';

import 'app/modules/profile_module/profile_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LelangKuy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      getPages: AppPages.pages,
      initialRoute: Routes.SPLASH,
    );
  }
}