// lib/bindings/home_binding.dart
import 'package:get/get.dart';
import 'package:sheetal_raj_jal/controllers/loginController.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LoginController.new);

  }
}
