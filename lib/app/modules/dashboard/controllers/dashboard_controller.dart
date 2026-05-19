import 'package:get/get.dart';

class DashboardController extends GetxController {
  // 1. State untuk navigasi antar Tab (Home, Stats, Security, Profile)
  // .obs membuat variabel ini reaktif
  var tabIndex = 0.obs;

  // Fungsi untuk mengubah halaman berdasarkan indeks yang dipilih di BottomNav
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  // 2. Simulasi data riwayat (Data ini akan ditampilkan di konten Home/Dashboard)
  // Kita buat reaktif agar jika ada penambahan data, UI otomatis update
  final List<Map<String, dynamic>> history = [
    {
      'title': 'Ekspor Data Pelanggan',
      'time': '15 Jan 10:23',
      'status': 'BERHASIL',
      'icon': 0 // 0 untuk icon Download/Ekspor
    },
    {
      'title': 'Matikan Plugin Security',
      'time': '14 Jan 14:15',
      'status': 'GAGAL',
      'icon': 1 // 1 untuk icon Power/Matikan
    },
    {
      'title': 'Edit Halaman Utama',
      'time': '13 Jan 09:45',
      'status': 'BERHASIL',
      'icon': 2 // 2 untuk icon Edit/Notes
    },
  ].obs;

  // 3. Fungsi Aksi Sederhana
  void openNotification() {
    // Logika membuka halaman notifikasi atau modal
    print("Menampilkan daftar notifikasi keamanan...");
  }

  // Fungsi ini bisa dipanggil dari logo profil di AppBar untuk pindah ke tab Profil (indeks 3)
  void goToProfileTab() {
    tabIndex.value = 3;
  }

  @override
  void onInit() {
    super.onInit();
    // Di sini Anda bisa memanggil fungsi untuk mengambil data dari server WordPress Anda
    // contoh: fetchHistoryData();
    print("Dashboard Controller Initialized");
  }

  @override
  void onClose() {
    // Membersihkan resource jika diperlukan
    super.onClose();
  }
}