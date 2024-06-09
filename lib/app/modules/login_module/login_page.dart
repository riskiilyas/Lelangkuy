import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/modules/login_module/login_controller.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends GetView<LoginController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    Obx(
                          () => Column(
                        children: [
                          ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () async {
                              if (formKey.currentState!.validate()) {
                                final isValid =
                                await controller.login();
                                if (isValid) {
                                  // Navigate to home page
                                  Get.offAllNamed(Routes.HOME);
                                } else {
                                  // Show error message
                                  Get.snackbar(
                                    'Error',
                                    'Invalid email or password',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                }
                              }
                            },
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text('Login'),
                          ),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.REGISTER);
                            },
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text('Register'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
