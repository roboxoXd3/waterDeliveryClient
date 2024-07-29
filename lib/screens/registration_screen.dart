import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheetal_raj_jal/constants/constant.dart';
import 'package:sheetal_raj_jal/routes/app_pages.dart';
import '../constants/colors.dart';
import '../controllers/registrationController.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
        init: RegistrationController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                // Background image
                Image.asset(
                  'assets/water_background.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                // Semi-transparent overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue.withOpacity(0.3),
                        Colors.blue.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
                // Main content
                Form(
                  key: controller.registerKey,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // App logo
                          SvgPicture.asset(
                            'assets/logo.svg',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 20),
                          // Welcome text
                          Text(
                            'welcome'.tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightTextColor,
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Registration form
                          _buildGlassCard(
                            child: Column(
                              children: [
                                _buildTextField(
                                  'full_name'.tr,
                                  Icons.person,
                                  controller: controller.nameController,
                                  validator: (value) =>
                                      ConstantsUtils.validateNameField(
                                          value ?? "", context),
                                  textType: TextInputType.name,
                                ),
                                const SizedBox(height: 20),
                                _buildTextField(
                                  'phone_number'.tr,
                                  Icons.phone,
                                  controller: controller.phoneNumberController,
                                  validator: (value) =>
                                      ConstantsUtils.validatePhoneNumber(
                                          value ?? "", context),
                                  textType: TextInputType.number,inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                                ),
                                const SizedBox(height: 20),
                                _buildTextField(
                                  'email'.tr,
                                  Icons.email,
                                  controller: controller.emailController,
                                  validator: (value) =>
                                      ConstantsUtils.validateEmail(
                                          value ?? "", context),
                                  textType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 20),
                                _buildTextField(
                                  'password'.tr,
                                  Icons.lock,
                                  isPassword: true,
                                  controller: controller.passwordController,
                                  validator: (value) =>
                                      ConstantsUtils.validatePassword(
                                          value ?? "", context),
                                  textType: TextInputType.name,
                                ),
                                const SizedBox(height: 30),
                                _buildSignUpButton(controller),
                                const SizedBox(height: 20),
                                _buildLoginLink(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Creates a card with a frosted glass effect
  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white.withOpacity(0.2),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }

  // Creates a styled text input field
  Widget _buildTextField(String label, IconData icon,
      {bool isPassword = false,
      TextEditingController? controller,
      FormFieldValidator<String>? validator,
      TextInputType? textType,  List<TextInputFormatter>? inputFormatters,}) {
    return TextFormField(
      obscureText: isPassword,
      style: const TextStyle(color: AppColors.darkTextColor),
      controller: controller,
      validator: validator,
      keyboardType: textType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: AppColors.darkTextColor.withOpacity(0.7)),
        prefixIcon: Icon(icon, color: AppColors.primaryColor),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.inputBorderColor),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.errorColor),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.errorColor),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  // Creates a styled sign-up button
  Widget _buildSignUpButton(RegistrationController controller) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: AppColors.primaryColor,
      minWidth: double.infinity,
      height: 46,
      onPressed: () {
        if (controller.registerKey.currentState!.validate()) {
          controller.isLoading = true;
          controller.update();
          controller.register();
        }
      },
      child: controller.isLoading
          ? const CircularProgressIndicator(color: AppColors.backgroundColor)
          : Text(
              'signup'.tr,
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
            ),
    );
  }

  // Creates a link to the login page
  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'already_have_account'.tr,
          style: const TextStyle(color: AppColors.darkTextColor, fontSize: 15),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          child: Text(
            'login'.tr,
            style: const TextStyle(
              color: AppColors.darkTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          onTap: () => Get.toNamed(Routes.loginPage),
        ),
      ],
    );
  }
}
