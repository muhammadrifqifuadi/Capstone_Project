import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../../../routes/app_pages.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FB),
      body: SafeArea(
        child: Stack(
          children: [
            // Background decorative shields
            Positioned(
              top: -40,
              right: -40,
              child: _buildBgShield(120, opacity: 0.06),
            ),
            Positioned(
              top: 60,
              right: 20,
              child: _buildBgShield(60, opacity: 0.08),
            ),
            Positioned(
              bottom: 200,
              left: -30,
              child: _buildBgShield(90, opacity: 0.06),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const SizedBox(height: 60),

                  // Logo
                  Image.asset(
                    'assets/images/logo_faceguard.png',
                    width: 180,
                    height: 160,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 36),

                  // Title
                  const Text(
                    'FaceGuard',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A3A5C),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Amankan Website WordPress-mu\ndengan Wajah',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 44),

                  // Feature list
                  _FeatureItem(
                    icon: Icons.lock_rounded,
                    text: 'Verifikasi aksi sensitif',
                  ),
                  const SizedBox(height: 18),
                  _FeatureItem(
                    icon: Icons.person_rounded,
                    text: 'Pengenalan wajah real-time',
                  ),
                  const SizedBox(height: 18),
                  _FeatureItem(
                    icon: Icons.videocam_rounded,
                    text: 'Rekaman video liveness',
                  ),

                  const Spacer(),

                  // Daftar Sekarang button
                  _PrimaryButton(
                    label: 'Daftar Sekarang',
                    onPressed: () => Get.toNamed(Routes.REGISTER),
                  ),

                  const SizedBox(height: 18),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun? ',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.LOGIN),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF00A693),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBgShield(double size, {required double opacity}) {
    return Opacity(
      opacity: opacity,
      child: Icon(
        Icons.security_rounded,
        size: size,
        color: const Color(0xFF1A3A5C),
      ),
    );
  }
}

// ─── Feature Item ─────────────────────────────────────────────────────────────

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FeatureItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFF1A3A5C).withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF1A3A5C), size: 20),
        ),
        const SizedBox(width: 14),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF2D3748),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─── Primary Button ───────────────────────────────────────────────────────────

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  const _PrimaryButton({required this.label, required this.onPressed});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00A693), Color(0xFF008F7A)],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00A693).withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
