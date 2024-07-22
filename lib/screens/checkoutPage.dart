import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheetal_raj_jal/widgets/buildOrderSummaryWidget.dart';
import '../controllers/checkoutController.dart';
import '../widgets/deliveryTimeWidget.dart';
import '../widgets/paymentMethodWidget.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('checkout'.tr),
      ),
      body: AnimatedList(
        initialItemCount: 5,
        itemBuilder: (context, index, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildSection(index),
              ),
            ),
          );
        },
      ),
    );
  }

// New code snippet
  Widget _buildSection(int index) {
    switch (index) {
      case 0:
        return _buildSelectedAddress();
      case 1:
        return const DeliveryTimeWidget();
      case 2:
        return BuildOrderSummary();
      case 3:
        return const PaymentMethodWidget();
      case 4:
        return _buildPlaceOrderButton();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSelectedAddress() {
    return Obx(() => Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Delivery Address',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(controller.formattedSelectedAddress),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: controller.changeAddress,
                  child: Text(controller.selectedAddress.value == null
                      ? 'Select Address'
                      : 'Change Address'),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildPlaceOrderButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.placeOrder(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text('place_order'.tr),
      ),
    );
  }

  // Widget _buildPromoCode() {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: TextField(
  //           decoration: InputDecoration(
  //             hintText: 'enter_promo_code'.tr,
  //             border: const OutlineInputBorder(),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(width: 10),
  //       ElevatedButton(
  //         onPressed: () => controller.applyPromoCode(),
  //         child: Text('apply'.tr),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildAdditionalInstructions() {
  //   return TextField(
  //     maxLines: 3,
  //     decoration: InputDecoration(
  //       hintText: 'additional_instructions'.tr,
  //       border: const OutlineInputBorder(),
  //     ),
  //   );
  // }

  //  Widget _buildTermsAndConditions() {
  //   return Row(
  //     children: [
  //       Obx(() => Checkbox(
  //             value: controller.termsAccepted.value,
  //             onChanged: (value) => controller.termsAccepted.value = value!,
  //           )),
  //       Expanded(
  //         child: Text('accept_terms_and_conditions'.tr),
  //       ),
  //       TextButton(
  //         onPressed: () => controller.viewTermsAndConditions(),
  //         child: Text('view'.tr),
  //       ),
  //     ],
  //   );
  // }
}
