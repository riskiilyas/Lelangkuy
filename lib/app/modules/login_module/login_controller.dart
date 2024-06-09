import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/data/model/user.dart';
import 'package:lelangkuy/app/data/provider/db.dart';
import 'package:lelangkuy/app/data/provider/pref.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final DatabaseHelper db = DatabaseHelper();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  late int userId;
  late String userName;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<bool> login() async {
    isLoading(true);
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Validate email and password
      if (email.isEmpty || password.isEmpty) {
        throw 'Please enter both email and password';
      }

      // Fetch user from database
      final User? user = await db.getUserByEmailAndPassword(email, password);


      if (user != null) {
        Get.snackbar(
          'Success',
          'User Login successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        userId = user.id;
        userName = user.name;
        await PrefManager.setEmail(user.email);
        await PrefManager.setPassword(user.password);
        await PrefManager.setName(user.name);
        await PrefManager.setUid(user.id);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    } finally {
      isLoading(false);
    }
  }
}
