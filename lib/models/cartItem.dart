import 'package:get/get.dart';
import 'package:sheetal_raj_jal/models/product.dart';

class CartItem {
  final Product product;
  final RxInt quantity;

  CartItem({
    required this.product,
    int quantity = 1,
  }) : quantity = quantity.obs;

  double get totalPrice => product.price * quantity.value;

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity.value,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}
