import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
// Import ini sekarang akan terpakai di tombol "Masuk"
import '../../../routes/app_pages.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2A9D8F); 
    const headerColor = Color(0xFF1E3A5F);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          // Kembali ke halaman sebelumnya
          onPressed: () => Get.back(), 
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Text(
                'Daftar Akun Baru',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: headerColor),
              ),
              const SizedBox(height: 8),
              const Text(
                'Isi data berikut untuk memulai', 
                style: TextStyle(color: Colors.grey)
              ),
              const SizedBox(height: 32),

              _inputLabel("Username"),
              _textField(controller.usernameController, "budi_umkm", Icons.person_outline),

              _inputLabel("Email"),
              _textField(controller.emailController, "budi@tokobaju.com", Icons.email_outlined),

              _inputLabel("Password"),
              Obx(() => _textField(
                controller.passwordController, "••••••••", Icons.lock_outline,
                isPassword: true, 
                isObscure: controller.isPasswordHidden.value,
                onToggle: controller.togglePassword,
                helper: "Minimal 8 karakter, 1 huruf besar dan 1 angka"
              )),

              _inputLabel("Konfirmasi Password"),
              Obx(() => _textField(
                controller.confirmPasswordController, "••••••••", Icons.lock_outline,
                isPassword: true, 
                isObscure: controller.isConfirmPasswordHidden.value,
                onToggle: controller.toggleConfirmPassword
              )),

              _inputLabel("URL Website"),
              _textField(controller.urlController, "https://tokobaju.com", Icons.language, 
                helper: "Masukkan alamat website WordPress Anda"),

              const SizedBox(height: 20),

              // Checkbox S&K
              Row(
                children: [
                  Obx(() => Checkbox(
                    value: controller.isTermsAccepted.value,
                    onChanged: controller.toggleTerms,
                    activeColor: primaryColor,
                  )),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        text: 'Saya menyetujui ',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        children: [
                          TextSpan(
                            text: 'Syarat & Ketentuan', 
                            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)
                          ),
                          TextSpan(text: ' dan '),
                          TextSpan(
                            text: 'Kebijakan Privasi', 
                            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // TOMBOL DAFTAR
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.register, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text(
                    'Daftar', 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              const Row(children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16), 
                  child: Text("ATAU", style: TextStyle(fontSize: 12, color: Colors.grey))
                ),
                Expanded(child: Divider()),
              ]),
              const SizedBox(height: 24),

              // Tombol Google
              OutlinedButton.icon(
                onPressed: () {},
                icon: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/2991/2991148.png', 
                  height: 20
                ),
                label: const Text(
                  "Daftar dengan Google", 
                  style: TextStyle(color: Colors.black)
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              const SizedBox(height: 24),

              // Navigasi ke Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sudah punya akun? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    // MENGGUNAKAN Routes.LOGIN agar import tidak kuning/unused
                    onTap: () => Get.offAllNamed(Routes.LOGIN), 
                    child: const Text(
                      "Masuk", 
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget Helper ---

  Widget _inputLabel(String label) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        label, 
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
      ),
    ),
  );

  Widget _textField(
    TextEditingController ctrl, 
    String hint, 
    IconData icon, 
    {bool isPassword = false, 
    bool isObscure = false, 
    VoidCallback? onToggle, 
    String? helper}
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: ctrl,
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20),
            suffixIcon: isPassword 
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, 
                    size: 20
                  ), 
                  onPressed: onToggle
                ) 
              : null,
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), 
              borderSide: BorderSide(color: Colors.grey.shade200)
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), 
              borderSide: BorderSide(color: Colors.grey.shade200)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), 
              borderSide: const BorderSide(color: Color(0xFF2A9D8F))
            ),
          ),
        ),
        if (helper != null) 
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4), 
            child: Text(
              helper, 
              style: const TextStyle(fontSize: 10, color: Colors.grey)
            )
          ),
      ],
    );
  }
}