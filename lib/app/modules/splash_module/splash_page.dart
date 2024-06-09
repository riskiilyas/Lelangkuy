import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/data/provider/pref.dart';
import 'package:lelangkuy/app/modules/splash_module/splash_controller.dart';

import '../../routes/app_pages.dart';


class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      final uid = await PrefManager.getUid();
      if(uid == null) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF39484b),
        child: Center(
          child: Image.asset("assets/splash.jpg"),
        ),
      ),
    );
  }
}
