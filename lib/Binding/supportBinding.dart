import 'package:get/get.dart';
import '../controllers/supportController.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SupportController.new);

  }
}
