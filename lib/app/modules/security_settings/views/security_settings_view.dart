import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/security_settings_controller.dart';

class SecuritySettingsView extends GetView<SecuritySettingsController> {
  const SecuritySettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0F172A);
    const softBlue = Color(0xFFF8FAFC);
    const accentTeal = Color(0xFF2A9D8F);

    return Scaffold(
      backgroundColor: softBlue,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryBlue),
          onPressed: () => Get.back(),
        ),
        title: const Text('Security Settings', 
            style: TextStyle(color: primaryBlue, fontWeight: FontWeight.w900, fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.refresh, color: primaryBlue), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. KARTU TINGKAT KEAMANAN (GRADIENT)
            _buildSecurityLevelCard(accentTeal),
            const SizedBox(height: 32),

            // 2. VERIFIKASI WAJAH SECTION
            _buildSectionLabel("VERIFIKASI WAJAH"),
            _buildFaceVerifGroup(accentTeal),
            const SizedBox(height: 32),

            // 3. AKSI SENSITIF SECTION
            _buildSectionLabel("AKSI SENSITIF"),
            const Text(
              "Pilih aksi mana yang wajib diverifikasi dengan wajah",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 16),
            _buildSensitiveActionList(accentTeal),
            const SizedBox(height: 40),

            // 4. TOMBOL SIMPAN & RESET
            _buildActionButtons(primaryBlue, accentTeal),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildSecurityLevelCard(Color teal) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF2A9D8F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Tingkat Keamanan", style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Obx(() => Row(
            children: [
              const Icon(Icons.circle, color: Colors.lightGreenAccent, size: 20),
              const SizedBox(width: 8),
              Text(controller.levelText.toUpperCase(), 
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
            ],
          )),
          const SizedBox(height: 24),
          Obx(() => SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white24,
              thumbColor: Colors.white,
              overlayColor: Colors.white10,
              valueIndicatorTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            child: Slider(
              value: controller.securityLevel.value,
              min: 0, max: 2, divisions: 2,
              onChanged: (val) => controller.securityLevel.value = val,
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Low", style: TextStyle(color: Colors.white60, fontSize: 11)),
              Text("Medium", style: TextStyle(color: Colors.white60, fontSize: 11)),
              Text("High", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Semakin tinggi tingkat keamanan, semakin banyak verifikasi yang diperlukan",
            style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildFaceVerifGroup(Color teal) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          _buildSwitchTile(Icons.face, "Wajib Verifikasi Wajah", "Verifikasi wajah diperlukan untuk semua aksi sensitif", controller.isFaceAuthRequired, teal),
          const Divider(height: 1, indent: 70),
          _buildSwitchTile(Icons.videocam_outlined, "Liveness Detection", "Mencegah spoofing dengan foto atau video", controller.isLivenessEnabled, teal),
          const Divider(height: 1, indent: 70),
          _buildSwitchTile(Icons.video_collection_outlined, "Rekam Video Audit", "Rekam video 3 detik untuk setiap verifikasi", controller.isVideoAuditEnabled, teal),
        ],
      ),
    );
  }

  Widget _buildSensitiveActionList(Color teal) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Obx(() => Column(
        children: controller.sensitiveActions.keys.map((key) {
          return CheckboxListTile(
            value: controller.sensitiveActions[key],
            onChanged: (val) => controller.toggleAction(key),
            activeColor: teal,
            title: Text(key, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            controlAffinity: ListTileControlAffinity.leading,
            checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          );
        }).toList(),
      )),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String sub, RxBool state, Color teal) {
    return Obx(() => ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: CircleAvatar(backgroundColor: Colors.blueGrey.shade50, child: Icon(icon, color: Colors.blueGrey)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
      subtitle: Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: Switch.adaptive(value: state.value, onChanged: (val) => state.value = val, activeColor: teal),
    ));
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 1.1)),
    );
  }

  Widget _buildActionButtons(Color dark, Color teal) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: teal,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("Simpan Pengaturan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {},
          child: const Text("Reset ke Pengaturan Default", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}