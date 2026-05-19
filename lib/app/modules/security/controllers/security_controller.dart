import 'package:get/get.dart';

class SecurityController extends GetxController {
  // Data Ringkasan
  var totalAttacks = 23.obs;
  var failedLogins = 156.obs;
  var blockedIPs = 8.obs;
  var activeAnomalies = 3.obs;

  // Data Pola Serangan
  final List<Map<String, dynamic>> attackPatterns = [
    {
      'type': 'Brute Force Attack',
      'detail': '120 percobaan | IP: 185.24.xx.xx',
      'time': '5 menit lalu',
      'level': 'HIGH',
    },
    {
      'type': 'Credential Stuffing',
      'detail': '15 IP berbeda',
      'time': '15 menit lalu',
      'level': 'CRITICAL',
    },
  ];

  // Data Tabel IP
  final List<Map<String, dynamic>> blockedIpList = [
    {'ip': '185.24.63.21', 'hits': '47x', 'time': '15 Jan 10:23', 'status': 'Permanen'},
    {'ip': '103.56.89.12', 'hits': '23x', 'time': '15 Jan 09:15', 'status': '24 Jam'},
  ];
}