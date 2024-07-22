// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/orderController.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        init: OrderController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('my-orders'.tr,
                  style: const TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.blue),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildActiveOrderCard(controller),
                const SizedBox(height: 20),
                Text(
                  'past_orders'.tr,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildPastOrderList(controller),
              ],
            ),
          );
        });
  }

  Widget _buildActiveOrderCard(OrderController controller) {
    return Obx(() {
      final order = controller.activeOrder.value;
      if (order == null) return const SizedBox.shrink();

      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'active_order'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Chip(
                    label: Text(order.formattedStatus),
                    backgroundColor: Colors.blue[100],
                    labelStyle: TextStyle(color: Colors.blue[800]),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text('${'order'.tr} #${order.id}'),
              ...order.items.map(
                  (item) => Text('${item.productName} x ${item.quantity}')),
              const SizedBox(height: 10),
              const LinearProgressIndicator(value: 0.7),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${'ordered'.tr}: ${order.formattedOrderDate}'),
                  Text('ETA: ${order.estimatedDeliveryTimeString}'),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => controller.trackOrder(order.id),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text('track_order'.tr),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPastOrderList(OrderController controller) {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.pastOrders.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text('${'order'.tr} #${controller.pastOrders[index].id}'),
                subtitle: Text(controller.pastOrders[index].items
                    .map((item) => '${item.productName} x ${item.quantity}')
                    .join(', ')),
                trailing: Text(controller.pastOrders[index].formattedTotalAmount),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: const Icon(Icons.check, color: Colors.blue),
                ),
                onTap: () {},
              ),
            );
          },
        ));
  }
}
