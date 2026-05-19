import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Data dummy profil
  var name = "Budi Santoso".obs;
  var email = "budi@tokobaju.com".obs;
  var username = "budi_umkm".obs;
  var phone = "+62 812 3456 7890".obs;

  void logout() {
    // Logika logout
    Get.offAllNamed('/login');
  }
}