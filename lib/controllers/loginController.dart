import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sheetal_raj_jal/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  String errorMessage = '';
  final box = GetStorage();
  final loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.user != null) {
        emailController.clear();
        passwordController.clear();
        await box.write('access_token', response.session!.accessToken);
        Get.offNamedUntil(
          Routes.homePage,
          (route) => false,
        );
      } else {
        errorMessage = 'Login failed. Please check your credentials.';
        Get.snackbar('Error', errorMessage);
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
      Get.snackbar('Error', errorMessage);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await box.read('access_token');
    return token != null;
  }

  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      await box.remove('access_token');
      Get.offNamedUntil(
        Routes.loginPage,
        (route) => false,
      );
    } catch (error) {
      print('Error logging out: $error');
      Get.snackbar('Logout Failed',
          'An error occurred while logging out. Please try again.');
    }
  }
}
