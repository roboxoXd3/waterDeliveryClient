import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/repositories/auth_repository.dart';

class RegistrationController extends GetxController {
  final supabase = Supabase.instance.client;

  AuthRepository? _authRepository;
  final registerKey = GlobalKey<FormState>();

  bool isLoading = false;
  String errorMessage = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> register() async {
    try {
      print("Attempting to register user"); 
      final user = await _authRepository!.registerUser(
        email: emailController.text,
        password: passwordController.text,
        fullName: nameController.text,
        phoneNumber: phoneNumberController.text,
      );

      if (user != null) {
        print("User registered successfully"); 
        Get.offNamed('/login');
        Get.snackbar('Success', 'Registration successful. Please log in.');
      } else {
        print("Registration failed, user is null"); 
        errorMessage = 'Registration failed. Please try again.';
        Get.snackbar('Error', 'Registration failed. Please try again.');
      }
    } catch (error) {
      print("Error occurred during registration: $error"); 
      errorMessage = 'An error occurred: $error';
      Get.snackbar('Error', 'An error occurred: $error');
    } finally {
      isLoading = false;
    }
    update();
  }
}
