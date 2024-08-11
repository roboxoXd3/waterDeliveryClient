import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_text_styles.dart';
import '../controllers/cartController.dart';

Widget buildOrderSummary() {
  final CartController controller = Get.find<CartController>();
  return Card(
    margin: const EdgeInsets.all(8),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary'.tr, style: AppTextStyles.headline),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('subtotal'.tr, style: AppTextStyles.bodyText),
              Text('₹${controller.subtotal}', style: AppTextStyles.bodyText),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('delivery_fee'.tr, style: AppTextStyles.bodyText),
              Text('₹${controller.deliveryFee}', style: AppTextStyles.bodyText),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('total'.tr, style: AppTextStyles.subtitle),
              Text('₹${controller.total}', style: AppTextStyles.subtitle),
            ],
          ),
        ],
      ),
    ),
  );
}
