import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../../../routes/app_pages.dart'; // Import rute sangat penting

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0F172A);
    const softBlue = Color(0xFFF8FAFC);

    return Scaffold(
      backgroundColor: softBlue,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryBlue),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Pengaturan',
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("TAMPILAN"),
            _buildSettingCard([
              _buildSwitchTile(
                Icons.dark_mode_outlined,
                "Mode Gelap",
                "Sesuaikan tampilan tema aplikasi",
                controller.isDarkMode,
                (val) => controller.toggleDarkMode(val),
              ),
              _buildSimpleTile(
                Icons.translate,
                "Bahasa",
                "Indonesia (Default)",
                onTap: () {
                  // Tambahkan navigasi bahasa jika perlu
                },
              ),
            ]),

            const SizedBox(height: 32),
            _buildSectionHeader("KEAMANAN"),
            _buildSettingCard([
              _buildSimpleTile(
                Icons.fingerprint,
                "Biometrik & Wajah",
                "Kelola verifikasi biometrik",
                onTap: () {
                  // Tambahkan navigasi biometrik jika perlu
                },
              ),
              // MODIFIKASI: Navigasi ke Halaman Security Settings
              _buildSimpleTile(
                Icons.shield_outlined,
                "Security Settings",
                "Konfigurasi proteksi agen",
                onTap: () => Get.toNamed(Routes.SECURITY_SETTINGS),
              ),
              _buildSimpleTile(
                Icons.history_toggle_off,
                "Aktivitas Login",
                "Lihat riwayat masuk akun",
                onTap: () {
                  // Tambahkan navigasi riwayat login jika perlu
                },
              ),
            ]),

            const SizedBox(height: 32),
            _buildSectionHeader("NOTIFIKASI"),
            _buildSettingCard([
              _buildSwitchTile(
                Icons.notifications_active_outlined,
                "Push Notification",
                "Dapatkan alert serangan real-time",
                controller.isNotificationEnabled,
                (val) => controller.toggleNotification(val),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: Colors.blueGrey,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildSettingCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile(
    IconData icon,
    String title,
    String sub,
    RxBool state,
    Function(bool) onChanged,
  ) {
    return Obx(
      () => Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            leading: Icon(icon, color: const Color(0xFF0F172A)),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            subtitle: Text(
              sub,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            trailing: Switch.adaptive(
              value: state.value,
              activeColor: const Color(0xFF2A9D8F),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  // MODIFIKASI: Menambahkan parameter VoidCallback onTap
  Widget _buildSimpleTile(
    IconData icon,
    String title,
    String sub, {
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          leading: Icon(icon, color: const Color(0xFF0F172A)),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          subtitle: Text(
            sub,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
      ],
    );
  }
}
