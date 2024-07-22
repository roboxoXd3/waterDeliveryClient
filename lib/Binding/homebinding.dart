
import 'package:get/get.dart';
import 'package:sheetal_raj_jal/controllers/HomePageControllert.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomePageController.new);

  }
}
