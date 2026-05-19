import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stats_controller.dart';

class StatsView extends GetView<StatsController> {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0F172A);
    const softBlue = Color(0xFFF8FAFC);

    return Container(
      color: softBlue,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 32),

            // 1. Ringkasan Performa Bulanan
            _buildMonthlySummary(primaryBlue),
            const SizedBox(height: 28),

            // 2. Analisis Jenis Serangan (Pie Chart)
            _buildSectionHeader("Kategori Serangan"),
            _buildAttackCategoryCard(),
            const SizedBox(height: 28),

            // 3. Jam Paling Rawan (Peak Hours)
            _buildSectionHeader("Waktu Paling Rawan"),
            _buildPeakTimeCard(primaryBlue),
            const SizedBox(height: 28),

            // 4. Laporan Negara Asal (Geographic)
            _buildSectionHeader("Negara Asal Terbanyak"),
            _buildGeographicCard(),
            
            const SizedBox(height: 100), // Agar tidak tertutup menu bawah
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Analisis Data', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
        Text('Laporan mendalam pola keamanan Anda.', style: TextStyle(color: Colors.blueGrey, fontSize: 14)),
      ],
    );
  }

  Widget _buildMonthlySummary(Color dark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("SERANGAN BULAN INI", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueGrey, letterSpacing: 1.1)),
              const SizedBox(height: 8),
              Obx(() => Text("${controller.totalSeranganBulanIni.value}", 
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: dark))),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.arrow_downward, size: 16, color: Colors.green),
                const SizedBox(width: 4),
                Obx(() => Text("${controller.persentasePenurunan.value}%", 
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w900, fontSize: 14))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAttackCategoryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
      child: Column(
        children: [
          // Sederhana Legend
          ...controller.attackTypes.map((type) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(width: 12, height: 12, decoration: BoxDecoration(color: Color(type['color']), shape: BoxShape.circle)),
                const SizedBox(width: 12),
                Text(type['name'], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const Spacer(),
                Text("${type['value']}%", style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.blueGrey)),
              ],
            ),
          )).toList(),
          const SizedBox(height: 20),
          // Bar progress bertumpuk sebagai simulasi Pie Chart yang modern
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: controller.attackTypes.map((type) => Expanded(
                flex: (type['value'] as double).toInt(),
                child: Container(height: 12, color: Color(type['color'])),
              )).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPeakTimeCard(Color dark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [dark, const Color(0xFF334155)]),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time_filled, color: Colors.amber, size: 40),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("WAKTU KRITIS", style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
              Obx(() => Text(controller.peakHour.value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900))),
              const Text("Sistem diperketat otomatis", style: TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGeographicCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
      child: Column(
        children: [
          _geoTile("Russia", "42%", Colors.red),
          _geoTile("China", "28%", Colors.orange),
          _geoTile("USA", "12%", Colors.blue),
        ],
      ),
    );
  }

  Widget _geoTile(String country, String percent, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(country, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const Spacer(),
          Text(percent, style: const TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(width: 12),
          Container(width: 40, height: 6, decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child: Align(alignment: Alignment.centerLeft, child: Container(width: 20, color: color)),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 16),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
    );
  }
}