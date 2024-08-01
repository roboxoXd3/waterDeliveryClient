// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../data/repositories/auth_repository.dart';

// // class RegistrationController extends GetxController {
// //   final supabase = Supabase.instance.client;

// //   late final AuthRepository? _authRepository; // Change to late final
// //   final registerKey = GlobalKey<FormState>();

// //   bool isLoading = false;
// //   String errorMessage = '';
// //   // New code -----------------
// //   // final RxString errorMessage = ''.obs; // Make this reactive
// //   // End of new code -----------
// //   TextEditingController nameController = TextEditingController();
// //   TextEditingController emailController = TextEditingController();
// //   TextEditingController phoneNumberController = TextEditingController();
// //   TextEditingController passwordController = TextEditingController();

// //   Future<void> register() async {
// //     try {
// //       print("Attempting to register user");
// //       final user = await _authRepository!.registerUser(
// //         email: emailController.text,
// //         password: passwordController.text,
// //         fullName: nameController.text,
// //         phoneNumber: phoneNumberController.text,
// //       );

// //       if (user != null) {
// //         print("User registered successfully");
// //         Get.offNamed('/login');
// //         Get.snackbar('Success', 'Registration successful. Please log in.');
// //       } else {
// //         print("Registration failed, user is null");
// //         errorMessage = 'Registration failed. Please try again.';
// //         Get.snackbar('Error', 'Registration failed. Please try again.');
// //       }
// //     } catch (error) {
// //       print("Error occurred during registration: $error");
// //       errorMessage = 'An error occurred: $error';
// //       Get.snackbar('Error', 'An error occurred: $error');
// //     } finally {
// //       isLoading = false;
// //     }
// //     update();
// //   }
// // }
// class RegistrationController extends GetxController {
//   final supabase = Supabase.instance.client;
//   late final AuthRepository _authRepository;  // Change to late final
//   final registerKey = GlobalKey<FormState>();

//   final RxBool isLoading = false.obs;
//   final RxString errorMessage = ''.obs;  // Make this reactive
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   void onInit() {
//     super.onInit();
//     _authRepository = AuthRepository();  // Initialize here
//   }

//   Future<void> register() async {
//     isLoading.value = true;
//     try {
//       print("Attempting to register user");
//       final user = await _authRepository.registerUser(  // Remove the '!'
//         email: emailController.text,
//         password: passwordController.text,
//         fullName: nameController.text,
//         phoneNumber: phoneNumberController.text,
//       );

//       if (user != null) {
//         print("User registered successfully");
//         Get.offNamed('/login');
//         Get.snackbar('Success', 'Registration successful. Please log in.');
//       } else {
//         print("Registration failed, user is null");
//         errorMessage.value = 'Registration failed. Please try again.';
//         Get.snackbar('Error', 'Registration failed. Please try again.');
//       }
//     } catch (error) {
//       print("Error occurred during registration: $error");
//       errorMessage.value = 'An error occurred: $error';
//       Get.snackbar('Error', 'An error occurred: $error');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onClose() {
//     nameController.dispose();
//     emailController.dispose();
//     phoneNumberController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data/repositories/auth_repository.dart';
import '../data/provider/auth_providers.dart';

class RegistrationController extends GetxController {
  late final AuthRepository _authRepository;
  final registerKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _authRepository = AuthRepository(
      AuthProvider(),
    );
  }

  Future<void> register() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      print("RegistrationController: Attempting to register user");
      final user = await _authRepository.registerUser(
        email: emailController.text,
        password: passwordController.text,
        fullName: nameController.text,
        phoneNumber: phoneNumberController.text,
      );

      if (user != null) {
        print("RegistrationController: User registered successfully");
        Get.offNamed('/login');
        Get.snackbar('Success', 'Registration successful. Please log in.');
      } else {
        print("RegistrationController: Registration failed, user is null");
        errorMessage.value = 'Registration failed. Please try again.';
        Get.snackbar('Error', 'Registration failed. Please try again.');
      }
    } catch (error) {
      print(
          "RegistrationController: Error occurred during registration: $error");
      errorMessage.value = 'An error occurred: $error';
      Get.snackbar('Error', error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
