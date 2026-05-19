// lib/modules/verification/views/verification_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/verification_controller.dart';

class VerificationView extends GetView<VerificationController> {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF0F172A);
    const tealColor = Color(0xFF2A9D8F);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(color: Color(0xFFF0F9FF), shape: BoxShape.circle),
                  child: const Icon(Icons.email_outlined, color: tealColor, size: 28),
                ),
                const SizedBox(height: 24),
                const Text('Verifikasi OTP', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: darkBlue)),
                const SizedBox(height: 12),
                
                // Email dinamis dari controller
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
                    children: [
                      const TextSpan(text: 'Masukkan kode yang kami kirim ke\n'),
                      TextSpan(
                        text: controller.userEmail, 
                        style: const TextStyle(fontWeight: FontWeight.bold, color: darkBlue)
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) => _otpBox(context, index)),
                  ),
                ),

                const SizedBox(height: 16),
                Obx(() => Text('Kode berlaku selama ${controller.timerText}',
                    style: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w500))),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.verify,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      elevation: 0,
                    ),
                    child: const Text('Verifikasi Sekarang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                // ... sisanya kirim ulang & kembali sama seperti sebelumnya ...
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _otpBox(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 54, width: 46,
      child: TextField(
        controller: controller.otpControllers[index],
        focusNode: controller.focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2A9D8F), width: 2)),
          filled: true, fillColor: Colors.white,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) controller.focusNodes[index + 1].requestFocus();
          if (value.isEmpty && index > 0) controller.focusNodes[index - 1].requestFocus();
        },
      ),
    );
  }
}