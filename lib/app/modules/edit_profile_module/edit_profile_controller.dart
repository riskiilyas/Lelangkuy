import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/data/provider/db.dart';
import 'package:lelangkuy/app/data/provider/pref.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';

class EditProfileController extends GetxController {
  // You can define your text editing controllers here
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final DatabaseHelper db = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    nameController.text = await PrefManager.getName() ?? "";
    emailController.text = await PrefManager.getEmail() ?? "";
    passwordController.text = await PrefManager.getPassword() ?? "";
  }

  Future<void> updateProfile() async {
    db.updateUser(await PrefManager.getUid() ?? 0, nameController.text,
        emailController.text, passwordController.text);

    await PrefManager.setName(nameController.text);
    await PrefManager.setEmail(emailController.text);
    await PrefManager.setPassword(passwordController.text);

    Get.offAllNamed(Routes.HOME);
    Get.snackbar(
      'Success',
      'Profile updated successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
