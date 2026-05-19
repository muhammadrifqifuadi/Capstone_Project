import 'package:get/get.dart';

class StatsController extends GetxController {
  // Data dummy untuk visualisasi
  var totalSeranganBulanIni = 423.obs;
  var persentasePenurunan = 15.obs;
  
  // Data untuk Pie Chart (Jenis Serangan)
  final List<Map<String, dynamic>> attackTypes = [
    {'name': 'Brute Force', 'value': 65.0, 'color': 0xFF6366F1},
    {'name': 'SQL Injection', 'value': 20.0, 'color': 0xFF2A9D8F},
    {'name': 'Spam Bot', 'value': 15.0, 'color': 0xFFF43F5E},
  ];

  // Jam Paling Rawan (0-23)
  var peakHour = "02:00 AM".obs;
}