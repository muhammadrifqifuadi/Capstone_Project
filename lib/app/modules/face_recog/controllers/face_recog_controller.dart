// lib/modules/face_recog/controllers/face_recog_controller.dart
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class FaceRecogController extends GetxController {
  var isScanning = false.obs;
  var progress = 0.0.obs;
  var statusMessage = "Posisikan wajah Anda di dalam bingkai".obs;

  void startEnrolment() async {
    isScanning.value = true;
    statusMessage.value = "Mengenali wajah...";

    // Simulasi progres pemindaian
    for (int i = 0; i <= 100; i += 5) {
      await Future.delayed(const Duration(milliseconds: 150));
      progress.value = i / 100;
      
      if (i == 30) statusMessage.value = "Tahan sebentar...";
      if (i == 60) statusMessage.value = "Menoleh sedikit ke kanan...";
      if (i == 90) statusMessage.value = "Hampir selesai...";
    }

    isScanning.value = false;
    statusMessage.value = "Wajah berhasil didaftarkan!";
  }

  void goToDashboard() {
    // Sesuai permintaan: Pindah ke Dashboard utama
    Get.offAllNamed(Routes.DASHBOARD);
  }
}