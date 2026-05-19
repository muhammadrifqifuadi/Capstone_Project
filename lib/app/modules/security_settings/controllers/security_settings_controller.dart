import 'package:get/get.dart';

class SecuritySettingsController extends GetxController {
  // Slider State
  var securityLevel = 2.0.obs; // 0: Low, 1: Medium, 2: High
  
  // Switch States
  var isFaceAuthRequired = true.obs;
  var isLivenessEnabled = true.obs;
  var isVideoAuditEnabled = true.obs;

  // Checkbox States (Aksi Sensitif)
  var sensitiveActions = {
    'Ekspor Data': true,
    'Matikan / Hapus Plugin': true,
    'Edit Halaman Penting': true,
    'Tambah / Hapus Admin': true,
    'Edit File Theme': true,
    'Ubah Pengaturan Website': true,
  }.obs;

  void toggleAction(String key) {
    sensitiveActions[key] = !sensitiveActions[key]!;
  }

  String get levelText {
    if (securityLevel.value == 0) return "Low";
    if (securityLevel.value == 1) return "Medium";
    return "High";
  }
}