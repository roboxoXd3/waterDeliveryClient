import 'package:get/get.dart';
import '../controllers/registrationController.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(RegistrationController.new);

  }
}
