import 'package:get/get.dart';
import 'package:sheetal_raj_jal/controllers/addressListController.dart';

class AddressListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AddressListController.new);

  }

  
}
