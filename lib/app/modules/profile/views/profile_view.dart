import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../routes/app_pages.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0F172A);
    const softBlue = Color(0xFFF8FAFC);
    const accentTeal = Color(0xFF2A9D8F);

    // MODIFIKASI: Langsung mengembalikan body saja, tanpa Scaffold & AppBar
    return Container(
      color: softBlue,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // Bagian Header Profil (Sebagai pengganti AppBar)
            _buildHeaderContent(primaryBlue),
            const SizedBox(height: 32),

            // Foto Profil & Ubah Foto
            _buildPhotoSection(primaryBlue),
            const SizedBox(height: 32),

            // Banner Email Terverifikasi
            _buildVerifiedBanner(),
            const SizedBox(height: 24),

            // Kartu Status Registrasi Wajah
            _buildFaceRegistrationCard(primaryBlue, accentTeal),
            const SizedBox(height: 24),

            // Statistik Singkat (3 Kotak)
            _buildMiniStats(),
            const SizedBox(height: 32),

            // Informasi Akun (Group)
            _buildSectionHeader("Informasi Akun"),
            _buildInfoGroup(primaryBlue),
            const SizedBox(height: 24),

            // Menu Pengaturan (Group)
            _buildMenuGroup(primaryBlue),
            const SizedBox(height: 32),

            // Tombol Logout
            _buildLogoutButton(),
            const SizedBox(height: 20),

            const Text(
              "FaceGuard version 1.0.0",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(
              height: 100,
            ), // Tambahan padding bawah agar tidak tertutup FAB
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  // Header manual untuk menggantikan AppBar di dalam Tab
  Widget _buildHeaderContent(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Profil Saya',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
        IconButton(
          icon: Icon(Icons.settings_outlined, color: color, size: 28),
          onPressed: () => Get.toNamed(Routes.SETTINGS),
        ),
      ],
    );
  }

  Widget _buildPhotoSection(Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF0F3443),
              child: Text(
                "BS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.camera_alt, size: 18, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Ubah Foto Profil",
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildVerifiedBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.teal),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email Terverifikasi",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF134E4A),
                ),
              ),
              Text(
                "Akun Anda telah diverifikasi",
                style: TextStyle(fontSize: 12, color: Colors.teal),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFaceRegistrationCard(Color dark, Color teal) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.face_retouching_natural,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  "Status Registrasi Wajah",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
              _buildBadge("Terdaftar"),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Terakhir diperbarui: 15 Jan 2025",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: teal),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Kelola Wajah",
                style: TextStyle(
                  color: Color(0xFF2A9D8F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _miniStatItem(Icons.language, "3", "Website"),
        _miniStatItem(Icons.verified_user_outlined, "47", "Aksi"),
        _miniStatItem(Icons.warning_amber_rounded, "5", "Anomali"),
      ],
    );
  }

  Widget _miniStatItem(IconData icon, String val, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blueGrey, size: 20),
            const SizedBox(height: 8),
            Text(
              val,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 12),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  Widget _buildInfoGroup(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _infoTile(Icons.person_outline, "Name", controller.name.value),
          _infoTile(Icons.email_outlined, "Email", controller.email.value),
          _infoTile(
            Icons.alternate_email,
            "Username",
            controller.username.value,
          ),
          _infoTile(
            Icons.phone_outlined,
            "Phone",
            controller.phone.value,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String label,
    String val, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.blueGrey, size: 22),
          title: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            val,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.grey,
            size: 20,
          ),
        ),
        if (!isLast) const Divider(height: 1, indent: 70),
      ],
    );
  }

  Widget _buildMenuGroup(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _menuTile(Icons.lock_outline, "Change Password"),
          _menuTile(Icons.devices, "Connected Devices"),
          _menuTile(Icons.notifications_none, "Notification Settings"),
          _menuTile(Icons.help_outline, "Help Center", isLast: true),
        ],
      ),
    );
  }

  Widget _menuTile(IconData icon, String title, {bool isLast = false}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.blueGrey, size: 22),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.grey,
            size: 20,
          ),
          onTap: () {},
        ),
        if (!isLast) const Divider(height: 1, indent: 70),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: controller.logout,
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text(
          "Logout",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_box, size: 12, color: Colors.green),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
