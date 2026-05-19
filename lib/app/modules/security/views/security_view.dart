import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/security_controller.dart';

class SecurityView extends GetView<SecurityController> {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0F172A);
    const softBlue = Color(0xFFF8FAFC);

    // MODIFIKASI: Menggunakan Container sebagai pengganti Scaffold
    // agar footer di DashboardView tetap terlihat.
    return Container(
      color: softBlue,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header manual pengganti AppBar jika ingin judul tetap ada di dalam Tab
            _buildHeaderManual(primaryBlue),
            const SizedBox(height: 24),

            // Judul Selamat Datang
            const Text(
              'Selamat datang, Budi',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: primaryBlue,
              ),
            ),
            const Text(
              'Berikut adalah ringkasan keamanan Anda hari ini.',
              style: TextStyle(color: Colors.blueGrey, fontSize: 14),
            ),

            const SizedBox(height: 28),
            _buildSecurityStatusCard(),

            const SizedBox(height: 32),
            _buildStatGrid(),

            const SizedBox(height: 36),
            _buildSectionHeader(
              "Pola Serangan Terdeteksi",
              actionText: "Lihat Semua",
            ),
            _buildAttackPatterns(),

            const SizedBox(height: 36),
            _buildSectionHeader("IP yang Diblokir", actionText: "Kelola"),
            _buildIPTable(),

            const SizedBox(height: 36),
            _buildRecommendationCard(),

            // Padding extra di bawah agar tidak tertutup Bottom Navigation Bar
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildHeaderManual(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'FaceGuard',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDFA),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.verified_user_rounded,
              color: Colors.teal,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STATUS KEAMANAN',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Colors.blueGrey,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '● AMAN',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.teal,
                ),
              ),
              Text(
                'Tidak ada ancaman aktif.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.8,
      children: [
        _statCard(
          "Total Serangan",
          "23",
          Icons.warning_amber_rounded,
          Colors.red,
          "12% ↑",
        ),
        _statCard(
          "Login Gagal",
          "156",
          Icons.lock_outline,
          Colors.indigo,
          null,
        ),
        _statCard(
          "IP Diblokir",
          "8",
          Icons.block_flipped,
          Colors.blueGrey,
          null,
        ),
        _statCard("Anomali Aktif", "3", Icons.bolt_rounded, Colors.cyan, null),
      ],
    );
  }

  Widget _statCard(
    String title,
    String val,
    IconData icon,
    Color color,
    String? trend,
  ) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            val,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (trend != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                trend,
                style: TextStyle(
                  color: Colors.red.shade800,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {String? actionText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          if (actionText != null)
            Text(
              actionText,
              style: const TextStyle(
                color: Color(0xFF2A9D8F),
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAttackPatterns() {
    return Column(
      children: controller.attackPatterns
          .map(
            (data) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['type'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          data['detail'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildBadge(data['level']),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildBadge(String level) {
    Color color = level == 'CRITICAL'
        ? const Color(0xFF7F1D1D)
        : (level == 'HIGH' ? Colors.red : Colors.orange);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        level,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildIPTable() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'IP ADDRESS',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'HITS',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'STATUS',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const Divider(height: 24, thickness: 1),
          ...controller.blockedIpList.map(
            (ip) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ip['ip'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const Text(
                    '47x',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      ip['status'],
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF9C3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.amber.shade200, width: 1),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber, size: 28),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Ganti password admin yang lemah untuk meningkatkan perlindungan.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF854D0E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Lihat Detail',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
