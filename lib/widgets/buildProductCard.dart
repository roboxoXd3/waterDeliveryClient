import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cartController.dart';
import '../models/product.dart';

Widget BuildProductCard(Product product,CartController cartController) {

  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          product.imageUrl,
          height: 60,
          width: 60,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error); // Fallback image in case of error
          },
        ),
        const SizedBox(height: 10),
        Text(
          product.name,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          '₹${product.price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, color: Colors.blue),
        ),
        ElevatedButton(
          onPressed: () {
            cartController.addToCart(product);
            Get.snackbar(
              'Added to Cart',
              '${product.nameKey} has been added to your cart',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10),
          ),
          child: const Icon(Icons.add),
        ),
      ],
    ),
  );
}
