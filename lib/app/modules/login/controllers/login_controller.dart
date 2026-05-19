// lib/modules/login/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() => isPasswordHidden.value = !isPasswordHidden.value;

  void login() {
    String email = emailController.text.trim();
    
    if (email.isNotEmpty && passwordController.text.isNotEmpty) {
      // Navigasi ke halaman verifikasi dengan membawa data
      Get.toNamed(Routes.VERIFICATION, arguments: {
        'source': 'login',
        'email': email,
      });
    } else {
      Get.snackbar("Error", "Email dan Password tidak boleh kosong",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void loginWithGoogle() {
    print("Fitur Google Login belum diaktifkan");
  }
}
