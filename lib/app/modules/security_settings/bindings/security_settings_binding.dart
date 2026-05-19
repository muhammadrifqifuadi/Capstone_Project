import 'package:get/get.dart';
import '../controllers/security_settings_controller.dart';

class SecuritySettingsBinding extends Bindings {
  @override
  void dependencies() {
    // Menggunakan lazyPut agar memory lebih efisien
    Get.lazyPut<SecuritySettingsController>(() => SecuritySettingsController());
  }
}