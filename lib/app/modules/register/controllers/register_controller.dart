import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Import ini penting agar controller tahu alamat Routes.PAIRING
import '../../../routes/app_pages.dart'; 

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final urlController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  var isTermsAccepted = false.obs;

  void togglePassword() => isPasswordHidden.value = !isPasswordHidden.value;
  void toggleConfirmPassword() => isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  void toggleTerms(bool? value) => isTermsAccepted.value = value ?? false;

  void register() {
    // 1. Validasi: Cek apakah checkbox sudah dicentang
    if (!isTermsAccepted.value) {
      Get.snackbar(
        "Peringatan", 
        "Anda harus menyetujui Syarat & Ketentuan",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
      return;
    }

    // 2. Jika sudah dicentang, langsung pindah ke halaman PAIRING
    // Routes.PAIRING harus sudah terdaftar di app_pages.dart
    Get.toNamed(Routes.VERIFICATION); 
    
    print("Berhasil mendaftar, menuju halaman verification...");
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    urlController.dispose();
    super.onClose();
  }
}