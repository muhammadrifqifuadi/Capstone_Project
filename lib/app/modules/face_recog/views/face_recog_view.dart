// lib/modules/face_recog/views/face_recog_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/face_recog_controller.dart';

class FaceRecogView extends GetView<FaceRecogController> {
  const FaceRecogView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryDark = Color(0xFF0F172A);
    const tealColor = Color(0xFF2A9D8F);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Registrasi Biometrik", 
          style: TextStyle(color: primaryDark, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.security, color: tealColor, size: 40),
            const SizedBox(height: 16),
            const Text(
              "Daftarkan Wajah Anda",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryDark),
            ),
            const SizedBox(height: 8),
            const Text(
              "Gunakan wajah Anda sebagai kunci akses website untuk mencegah login yang tidak sah.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
            
            const Spacer(),

            // Area Pemindaian Wajah
            Stack(
              alignment: Alignment.center,
              children: [
                // Ring Progres
                Obx(() => SizedBox(
                  width: 260, height: 260,
                  child: CircularProgressIndicator(
                    value: controller.progress.value,
                    strokeWidth: 4,
                    backgroundColor: Colors.grey.shade100,
                    valueColor: const AlwaysStoppedAnimation<Color>(tealColor),
                  ),
                )),
                // Area Kamera (Placeholder)
                Container(
                  width: 230, height: 230,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade50,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                  child: ClipOval(
                    child: Icon(Icons.face, size: 160, color: Colors.grey.shade300),
                  ),
                ),
                // Garis Scan Animasi (Opsional)
                Obx(() => controller.isScanning.value 
                  ? const Icon(Icons.view_in_ar, size: 230, color: Colors.tealAccent) 
                  : const SizedBox()),
              ],
            ),

            const SizedBox(height: 40),
            
            // Status Instruksi
            Obx(() => Text(
              controller.statusMessage.value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primaryDark),
            )),

            const Spacer(),

            // Tombol Navigasi Dinamis
            Obx(() => SizedBox(
              width: double.infinity,
              child: controller.progress.value < 1.0
                ? ElevatedButton(
                    onPressed: controller.isScanning.value ? null : controller.startEnrolment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDark,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: Text(controller.isScanning.value ? "Memproses..." : "Mulai Pemindaian",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  )
                : ElevatedButton(
                    onPressed: controller.goToDashboard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tealColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: const Text("Masuk ke Dashboard",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
            )),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}