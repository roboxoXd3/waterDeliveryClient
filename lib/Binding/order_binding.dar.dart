import 'package:get/get.dart';
import '../controllers/orderController.dart';

class OrderPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(OrderController.new);
  }
}
