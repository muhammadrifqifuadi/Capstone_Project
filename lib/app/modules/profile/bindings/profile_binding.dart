import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Menggunakan Get.lazyPut agar controller hanya dibuat saat halaman diakses
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
