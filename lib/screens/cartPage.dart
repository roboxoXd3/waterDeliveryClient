// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../constants/app_text_styles.dart';
import '../constants/colors.dart';
import '../controllers/cartController.dart';
import '../models/cartItem.dart';
import '../widgets/buildOrderSummaryWidget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GetBuilder<CartController>(
          init: CartController(),
          builder: (controller) {
            return Scaffold(
              appBar: AppBar(
                title: Text('cart'.tr,
                    style: AppTextStyles.appBarTitle
                        .copyWith(color: Colors.black)),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: controller.cartItems.isEmpty
                    ? buildEmptyCart()
                    : buildCartContent(controller),
              ),
              bottomNavigationBar: buildCheckoutButton(controller),
            );
          });
    });
  }

  Widget buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart_outlined,
              size: 100, color: AppColors.primaryColor),
          const SizedBox(height: 20),
          Text('empty_cart'.tr, style: AppTextStyles.headline),
          const SizedBox(height: 20),
          ElevatedButton(
            child: Text('continue_shopping'.tr),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  Widget buildCartContent(CartController controller) {
    return ListView(
      children: [
        ...controller.cartItems.map((item) => buildCartItem(item, controller)),
        buildOrderSummary(),
      ],
    );
  }

  Widget buildCartItem(CartItem item, CartController controller) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.20,
        children: [
          SlidableAction(
            autoClose: true,
            onPressed: (context) {},
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline_outlined,
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Image.network(item.product.imageUrl, width: 80, height: 80),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.product.nameKey, style: AppTextStyles.subtitle),
                    Text('₹${item.product.price}',
                        style: AppTextStyles.bodyText),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => controller.decreaseQuantity(item),
                  ),
                  Text('${item.quantity}', style: AppTextStyles.bodyText),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => controller.increaseQuantity(item),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCheckoutButton(CartController controller) {
    return controller.cartItems.isEmpty
        ? const IgnorePointer()
        : Container(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () => controller.proceedToCheckout(),
              child: Text('proceed_to_checkout'.tr,
                  style: AppTextStyles.buttonText),
            ),
          );
  }
}
