import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheetal_raj_jal/constants/constant.dart';
import 'package:sheetal_raj_jal/controllers/loginController.dart';
import 'dart:ui';

import '../constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                _buildBackground(),
                Form(
                  key: controller.loginKey,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildLogo(),
                          const SizedBox(height: 20),
                          _buildWelcomeText(),
                          const SizedBox(height: 40),
                          _buildGlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  style: const TextStyle(
                                      color: AppColors.darkTextColor),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: controller.emailController,
                                  validator: (val) =>
                                      ConstantsUtils.validateEmail(
                                          val!, context),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    hintText: 'email'.tr,
                                    hintStyle: TextStyle(
                                        color: AppColors.darkTextColor
                                            .withOpacity(0.7)),
                                    prefixIcon: const Icon(Icons.email,
                                        color: AppColors.primaryColor),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.inputBorderColor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.errorColor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.errorColor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),
                                TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  obscureText: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (val) =>
                                      ConstantsUtils.validatePassword(
                                          val!, context),
                                  controller: controller.passwordController,
                                  decoration: InputDecoration(
                                    hintText: 'password'.tr,
                                    hintStyle: TextStyle(
                                        color: AppColors.darkTextColor
                                            .withOpacity(0.7)),
                                    prefixIcon: const Icon(Icons.lock,
                                        color: AppColors.primaryColor),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.inputBorderColor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.errorColor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.errorColor),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 30),
                                _buildLoginButton(controller),
                                const SizedBox(height: 20),
                                _buildForgotPasswordLink(),
                                const SizedBox(height: 20),
                                // _buildOtpLoginOption(),
                                // const SizedBox(height: 20),
                                // _buildSocialLoginOptions(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildSignUpLink(),
                        ],
                      ),
                    ),
                  ),
                ),
                // Language toggle
                // _buildLanguageToggle(),
              ],
            ),
          );
        });
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/water_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[100]!.withOpacity(0.7),
              Colors.blue[600]!.withOpacity(0.7)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset(
      'assets/logo.svg',
      width: 100,
      height: 100,
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          'welcome_back'.tr,
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white.withOpacity(0.2),
          child: child,
        ),
      ),
    );
  }

  Widget _buildLoginButton(LoginController controller) {
    return Obx(() => ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            if (controller.loginKey.currentState!.validate()) {
              controller.login();
            }
          },
          child: controller.isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  'login'.tr,
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
        ));
  }

  Widget _buildForgotPasswordLink() {
    return TextButton(
      child: Text(
        'forgot_password'.tr,
        style: const TextStyle(color: AppColors.textColor, fontSize: 20),
      ),
      onPressed: () {
        // TODO: Implement forgot password logic
      },
    );
  }

  Widget _buildOtpLoginOption() {
    return TextButton(
      child: Text(
        'login_with_otp'.tr,
        style: const TextStyle(color: AppColors.textColor, fontSize: 20),
      ),
      onPressed: () {
        // TODO: Implement OTP login logic
      },
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'dont_have_an_account'.tr,
          style: const TextStyle(color: AppColors.darkTextColor, fontSize: 15),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          child: Text(
            'signup'.tr,
            style: const TextStyle(
                color: AppColors.darkTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 15
                // decoration: TextDecoration.underline,
                ),
          ),
          onTap: () {
            Get.toNamed('/registration');
          },
        ),
      ],
    );
  }
}
