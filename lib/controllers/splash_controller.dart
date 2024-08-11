import 'package:get/get.dart';
import 'package:sheetal_raj_jal/controllers/loginController.dart';
import 'package:sheetal_raj_jal/routes/app_pages.dart';

class SplashController extends GetxController {
  final LoginController authController = Get.put(LoginController());

  @override
  void onInit() async {
    super.onInit();

    Future<dynamic>.delayed(
        const Duration(
          seconds: 3,
        ), () async {
      if (await authController.isLoggedIn()) {
        Get.offAllNamed(Routes.homePage);
      } else {
        Get.offAllNamed(Routes.loginPage);
      }
    });
  }
}
