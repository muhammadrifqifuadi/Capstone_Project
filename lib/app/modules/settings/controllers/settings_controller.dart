import 'package:flutter/material.dart'; // WAJIB TAMBAHKAN INI
import 'package:get/get.dart';

class SettingsController extends GetxController {
  // State untuk Dark Mode
  var isDarkMode = false.obs;
  
  // State untuk Notifikasi
  var isNotificationEnabled = true.obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    
    // Menggunakan Get.changeThemeMode lebih stabil untuk switch tema
    Get.changeThemeMode(
      value ? ThemeMode.dark : ThemeMode.light,
    );
    
    // Atau jika tetap ingin menggunakan Get.changeTheme:
    // Get.changeTheme(value ? ThemeData.dark() : ThemeData.light());
  }

  void toggleNotification(bool value) {
    isNotificationEnabled.value = value;
  }
}