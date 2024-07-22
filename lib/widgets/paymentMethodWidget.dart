import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/checkoutController.dart';

class PaymentMethodWidget extends GetView<CheckoutController> {
  const PaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'payment_method'.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() => Column(
                  children: controller.paymentMethods
                      .map((method) => RadioListTile<String>(
                            title: Text(method),
                            value: method,
                            groupValue: controller.selectedPaymentMethod.value,
                            onChanged: (String? value) {
                              controller.selectedPaymentMethod.value = value!;
                            },
                          ))
                      .toList(),
                )),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('add_new_payment_method'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
