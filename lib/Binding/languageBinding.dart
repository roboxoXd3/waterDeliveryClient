// lib/bindings/language_binding.dart
import 'package:get/get.dart';
import '../controllers/languageController.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageController());
  }
}
