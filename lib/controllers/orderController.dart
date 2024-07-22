// import 'package:get/get.dart';
//
// import '../models/order.dart';
//
// class OrderController extends GetxController {
//   final activeOrder = Rx<Order?>(null);
//   final pastOrders = RxList<Order>([]);
//
//   @override
//   void onInit() {
//     super.onInit();
//     // TODO: Fetch active and past orders
//     fetchOrders();
//   }
//
//   void fetchOrders() {
//     // TODO: Implement API call to fetch orders
//   }
//
//   void trackOrder(String orderId) {
//     // TODO: Implement order tracking logic
//   }
// }
import 'package:get/get.dart';
import '../models/order.dart';

class OrderController extends GetxController {
  final activeOrder = Rx<Order?>(null);
  final pastOrders = RxList<Order>([]);

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() {
    // TODO: Replace this with actual API call
    activeOrder.value = Order(
      id: '12345',
      orderDate: DateTime.now(),
      status: OrderStatus.inTransit,
      items: [
        OrderItem(
          productId: '1',
          productName: '25 Litre Container',
          quantity: 2,
          price: 100,
        )
      ],
      totalAmount: 200,
      deliveryAddress: '123 Main St, Mairwa, Siwan District',
      estimatedDeliveryTime: DateTime.now().add(const Duration(hours: 2)),
      trackingNumber: 'TRK123456',
    );

    pastOrders.value = List.generate(
        5,
        (index) => Order(
              id: (12344 - index).toString(),
              orderDate: DateTime.now().subtract(Duration(days: index + 1)),
              status: OrderStatus.delivered,
              items: [
                OrderItem(
                  productId: '2',
                  productName: '15 Litre Bottle',
                  quantity: 1,
                  price: 100,
                )
              ],
              totalAmount: 100,
              deliveryAddress: '456 Elm St, Mairwa, Siwan District',
            ));
  }

  void trackOrder(String orderId) {
    // TODO: Implement order tracking logic
    print('Tracking order $orderId');
  }
}
