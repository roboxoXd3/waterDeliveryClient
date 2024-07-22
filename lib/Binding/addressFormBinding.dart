import 'package:get/get.dart';
import '../controllers/addressFormController.dart';

class AddressFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AddressFormController.new);

  }
}
