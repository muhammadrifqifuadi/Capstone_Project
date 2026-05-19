import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../profile/controllers/profile_controller.dart'; // Import ini
import '../../security/controllers/security_controller.dart'; // Import ini

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Controller Utama Dashboard
    Get.lazyPut<DashboardController>(() => DashboardController());
    
    // DAFTARKAN JUGA CONTROLLER ANAK DI SINI
    // Agar saat Tab Profile atau Security dibuka, controllernya sudah ada
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<SecurityController>(() => SecurityController());
  }
}