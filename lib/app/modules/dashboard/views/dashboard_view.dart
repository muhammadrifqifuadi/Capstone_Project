import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../../routes/app_pages.dart';
// Import view halaman lain agar bisa dimasukkan ke dalam Stack
import '../../security/views/security_view.dart';
import '../../profile/views/profile_view.dart';
import '../../stats/views/stats_view.dart'; // Import halaman statistik baru

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryDark = Color(0xFF1E293B);
    const accentTeal = Color(0xFF2A9D8F);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      // BODY menggunakan IndexedStack agar footer tetap diam di tempat
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            _buildHomeContent(primaryDark, accentTeal), // Tab 0: Home
            const StatsView(),      // Tab 1: Halaman Statistik Mendalam
            const SecurityView(),   // Tab 2: Halaman Security
            const ProfileView(),    // Tab 3: Halaman Profil
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNav(accentTeal),
    );
  }

  // --- TAB 0: KONTEN HALAMAN HOME/DASHBOARD ---
  Widget _buildHomeContent(Color primaryDark, Color accentTeal) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(primaryDark),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            _buildWebsiteCard(accentTeal),
            const SizedBox(height: 32),
            const Text(
              'AKSI CEPAT',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Colors.grey,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            _buildQuickActions(primaryDark),
            const SizedBox(height: 32),
            _buildHistoryHeader(primaryDark),
            const SizedBox(height: 16),
            _buildHistoryList(),
            const SizedBox(height: 40), 
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  AppBar _buildAppBar(Color color) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => controller.changeTabIndex(3), // Pindah ke Tab Profil
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'FaceGuard',
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: controller.openNotification,
          icon: Icon(Icons.notifications_none, color: color),
        ),
      ],
    );
  }

  Widget _buildWebsiteCard(Color teal) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.language, color: Color(0xFF2563EB)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Toko Baju UMKM',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 14, color: teal),
                    const SizedBox(width: 4),
                    Text(
                      'Terhubung',
                      style: TextStyle(
                        color: teal,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Heartbeat: 2 menit lalu',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(Color dark) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Get.toNamed(Routes.FACE_RECOG),
            child: _actionCard(
              'Verifikasi Aksi',
              Icons.photo_camera_outlined,
              dark,
              Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => controller.changeTabIndex(2), // Pindah ke Tab Security
            child: _actionCard(
              'Security',
              Icons.security,
              const Color(0xFFEFF6FF),
              dark,
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionCard(String title, IconData icon, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textCol),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: textCol,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryHeader(Color dark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'RIWAYAT TERAKHIR',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: Colors.grey,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Lihat Semua',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF2A9D8F),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryList() {
    return Column(
      children: controller.history.map((item) {
        bool isSuccess = item['status'] == 'BERHASIL';
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              _historyIcon(item['icon']),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      item['time'],
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
              _statusBadge(item['status'], isSuccess),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _historyIcon(int type) {
    IconData icon = type == 0
        ? Icons.download
        : (type == 1 ? Icons.power_settings_new : Icons.edit_note);
    Color col = type == 0
        ? Colors.blue
        : (type == 1 ? Colors.red : Colors.orange);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: col.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: col, size: 20),
    );
  }

  Widget _statusBadge(String label, bool success) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: success ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: success ? Colors.green : Colors.red,
          fontSize: 9,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  // --- NAVIGATION HELPERS ---

  Widget _buildBottomNav(Color active) {
    return BottomAppBar(
      elevation: 10,
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navItem(Icons.home_filled, 'Home', 0, active),
            _navItem(Icons.analytics_outlined, 'Stats', 1, active),
            _navItem(Icons.security, 'Security', 2, active),
            _navItem(Icons.person_outline, 'Profile', 3, active),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index, Color active) {
    return Obx(() {
      bool isSelected = controller.tabIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeTabIndex(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? active : Colors.grey.shade400,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? active : Colors.grey.shade400,
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}