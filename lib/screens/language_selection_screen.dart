import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../controllers/languageController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/languageButton.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      init: LanguageController(),
      builder: (controller) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue[100]!, Colors.blue[600]!],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/logo.svg',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'choose_language'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    LanguageButton(
                      onPressed: () {
                        controller.changeLanguage('en');
                        Get.toNamed('/registration');
                      },
                      text: 'English',
                      icon: Icons.language,
                    ),
                    const SizedBox(height: 20),
                    LanguageButton(
                      onPressed: () {
                        controller.changeLanguage('hi');
                        Get.toNamed('/registration');
                      },
                      text: 'हिंदी',
                      icon: Icons.language,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
