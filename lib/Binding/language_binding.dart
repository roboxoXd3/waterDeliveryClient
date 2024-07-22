
import 'package:get/get.dart';
import 'package:sheetal_raj_jal/controllers/languageController.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LanguageController.new);

  }
}
