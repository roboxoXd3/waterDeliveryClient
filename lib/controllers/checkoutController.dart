import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/cartItem.dart';
import 'addressListController.dart';

class CheckoutController extends GetxController {
  // Selected address
  final Rx<Map<String, dynamic>?> selectedAddress =
      Rx<Map<String, dynamic>?>(null);

  // Delivery time
  final selectedDate = Rxn<DateTime>();
  final selectedTimeSlot = 'Morning'.obs;
  final timeSlots = ['Morning', 'Afternoon', 'Evening'].obs;

  // Cart items
  final cartItems = <CartItem>[].obs;

  // Payment
  final paymentMethods = ['Cash on Delivery', 'Credit Card', 'UPI'].obs;
  final selectedPaymentMethod = Rx<String?>(null);

  // Terms and conditions
  final termsAccepted = false.obs;

  // Getters
  // double get subtotal => cartItems.fold(
  //     0, (sum, item) => sum + (item.product.price * item.quantity.value));
  // double get deliveryFee => 0.0; // Example fixed delivery fee
  // double get total => subtotal + deliveryFee;

  @override
  void onInit() {
    super.onInit();
    final addressListController = Get.find<AddressListController>();
    selectedAddress.value = addressListController.selectedAddress.value;
  }

  String get formattedSelectedAddress {
    if (selectedAddress.value != null) {
      final address = selectedAddress.value!;
      return '${address['street']}, ${address['city']}, ${address['state']} ${address['postal_code']}, ${address['country']}';
    }
    return 'No address selected';
  }

  void changeAddress() {
    Get.toNamed('/addresses');
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  void applyPromoCode() {
    // Implement promo code logic
  }

  void viewTermsAndConditions() {
    // Show terms and conditions
  }

  void placeOrder() {
    // if (!termsAccepted.value) {
    //   Get.snackbar('Error', 'Please accept the terms and conditions');
    //   return;
    // }
    if (selectedAddress.value == null) {
      Get.snackbar('Error', 'Please select a delivery address');
      return;
    }
    if (selectedDate.value == null) {
      Get.snackbar('Error', 'Please select a delivery date');
      return;
    }
    if (selectedPaymentMethod.value == null) {
      Get.snackbar('Error', 'Please select a payment method');
      return;
    }

    // Implement order placement logic
    // You can now access selectedAddress.value here for the delivery address
  }
}
