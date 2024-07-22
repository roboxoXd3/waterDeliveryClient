import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/checkoutController.dart';

class DeliveryTimeWidget extends GetView<CheckoutController> {
  const DeliveryTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'delivery_time'.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Obx(() => Text(
                        controller.selectedDate.value != null
                            ? controller.selectedDate.value!
                                .toString()
                                .split(' ')[0]
                            : 'select_date'.tr,
                        // style: TextStyle(color: Colors.red),
                      )),
                ),
                ElevatedButton(
                  onPressed: () => controller.selectDate(context),
                  child: Text('change_date'.tr),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Obx(
            //   () => DropdownButton<String>(
            //     isExpanded: true,
            //     value: controller.selectedTimeSlot.value,
            //     onChanged: (String? newValue) {
            //       controller.selectedTimeSlot.value = newValue!;
            //     },
            //     items: controller.timeSlots
            //         .map<DropdownMenuItem<String>>((String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: Text(value),
            //       );
            //     }).toList(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
