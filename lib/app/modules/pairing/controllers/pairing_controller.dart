import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class PairingController extends GetxController {
  final apiKeyController = TextEditingController();

  void scanQRCode() {
    // Logika untuk membuka kamera dan scan QR
    print("Membuka kamera untuk Scan QR...");
    
    // Simulasi jika scan berhasil, bisa langsung arahkan ke Face Recog
    // Get.toNamed(Routes.FACE_RECOG);
  }

  void verifyManualKey() {
    String key = apiKeyController.text.trim();
    
    // 1. Validasi Input
    if (key.isEmpty) {
      Get.snackbar(
        'Gagal', 
        'API Key tidak boleh kosong',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(15),
      );
      return;
    }

    // 2. Simulasi Verifikasi ke Plugin WordPress
    print("Memverifikasi API Key: $key");

    // 3. Navigasi ke Face Recognition
    // Sesuai permintaan Anda, setelah klik verifikasi di sini, masuk ke setor muka
    Get.toNamed(Routes.FACE_RECOG);
  }

  void learnMore() {
    // Logika untuk membuka browser atau halaman edukasi
    print("Membuka halaman info FaceGuard for WP");
  }

  @override
  void onClose() {
    apiKeyController.dispose();
    super.onClose();
  }
}