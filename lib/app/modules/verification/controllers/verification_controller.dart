// lib/modules/verification/controllers/verification_controller.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class VerificationController extends GetxController {
  final List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  
  var remainingTime = 300.obs;
  Timer? _timer;

  // Variabel penampung data dari halaman sebelumnya
  String source = '';
  String userEmail = '';

  @override
  void onInit() {
    // Mengambil argumen yang dikirim dari Login atau Register
    source = Get.arguments?['source'] ?? 'register';
    userEmail = Get.arguments?['email'] ?? 'user@email.com';
    
    startTimer();
    super.onInit();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  String get timerText {
    int minutes = remainingTime.value ~/ 60;
    int seconds = remainingTime.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void verify() {
    // Alur sesuai permintaan Anda: Langsung klik tanpa validasi kode berat di sini
    if (source == 'login') {
      // Jika dari login, langsung ke Dashboard utama
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      // Jika dari registrasi, harus ke tahap pairing plugin dulu
      Get.offNamed(Routes.PAIRING);
    }
  }

  void resendCode() {
    remainingTime.value = 300;
    startTimer();
  }

  @override
  void onClose() {
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }
}