import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/modules/register_module/register_controller.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';

class RegisterPage extends GetView<RegisterController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            // Replace with your background image path
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
                    const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
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
                          () => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () async {
                          if (formKey.currentState!.validate()) {
                            await controller.register();
                          }
                        },
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : const Text('Register'),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Obx(
                          () => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                          Get.offAllNamed(Routes.LOGIN);
                        },
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : const Text('Login'),
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
