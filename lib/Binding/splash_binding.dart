import 'package:get/get.dart';
import 'package:sheetal_raj_jal/controllers/splash_controller.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SplashController.new);
  }
}
