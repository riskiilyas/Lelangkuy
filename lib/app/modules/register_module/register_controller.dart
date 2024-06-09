import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/data/model/user.dart';
import 'package:lelangkuy/app/data/provider/db.dart';
import 'package:lelangkuy/app/data/provider/pref.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final DatabaseHelper db = DatabaseHelper();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    isLoading(true);
    try {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Validate inputs
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        throw 'Please fill in all fields';
      }

      // Check if user with the provided email already exists
      final existingUser = await db.getUserByEmail(email);
      if (existingUser != null) {
        throw 'User with this email already exists';
      }

      // Create new user and insert into the database
      final newUser = User(
        name: name,
        email: email,
        password: password,
        id: 0,
      );
      await db.insertUser(newUser);
      final user = await db.getUserByEmailAndPassword(email, password);

      final id = user!.id;
      await PrefManager.setEmail(email);
      await PrefManager.setPassword(password);
      await PrefManager.setName(name);
      await PrefManager.setUid(id);

      Get.snackbar(
        'Success',
        'User registered successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}
