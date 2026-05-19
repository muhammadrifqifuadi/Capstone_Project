import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pairing_controller.dart';


class PairingView extends GetView<PairingController> {
  const PairingView({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan kode warna yang konsisten dengan desain FaceGuard Anda
    const darkBlue = Color(0xFF0F172A);   
    const tealColor = Color(0xFF2A9D8F);  

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pairing Perangkat",
          style: TextStyle(color: darkBlue, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: darkBlue, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        
                        // Icon Logo Shield dengan background soft blue
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F7FF), 
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.security_update_good_outlined,
                            color: darkBlue,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Judul Utama
                        const Text(
                          'Hubungkan dengan Website',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: darkBlue,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),

                        // Deskripsi Instruksi
                        const Text(
                          'Pindai kode QR pada dashboard plugin\nFaceGuard di WordPress Anda untuk\nmenautkan perangkat ini.',
                          style: TextStyle(
                            fontSize: 14, 
                            color: Colors.grey, 
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),

                        // Tombol Utama: Scan QR
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: controller.scanQRCode,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            icon: const Icon(Icons.qr_code_scanner_rounded, size: 22),
                            label: const Text(
                              'Scan QR Code',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Divider "Atau"
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1)),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'atau masukkan kode', 
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1)),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Label Input Manual
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Input API Key Manual',
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 13, 
                              color: darkBlue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Field Input Manual
                        TextField(
                          controller: controller.apiKeyController,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Masukkan API Key dari WordPress',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            prefixIcon: const Icon(Icons.vpn_key_outlined, size: 20),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            contentPadding: const EdgeInsets.symmetric(vertical: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey.shade200),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey.shade200),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: tealColor, width: 1.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Tombol Klik Verifikasi Manual
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: controller.verifyManualKey,
                            borderRadius: BorderRadius.circular(8),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Verifikasi Kode',
                                style: TextStyle(
                                  color: tealColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Spacer untuk mendorong footer ke bawah
                        const Spacer(),
                        const SizedBox(height: 40),

                        // Footer Information
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Bingung cara menghubungkannya? ',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            GestureDetector(
                              onTap: controller.learnMore,
                              child: const Text(
                                'Lihat Panduan',
                                style: TextStyle(
                                  color: darkBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}