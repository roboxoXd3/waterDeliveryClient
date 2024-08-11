import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/cartItem.dart';
import '../models/product.dart';

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs;
  final _storage = GetStorage();
  double get subtotal => cartItems.fold(
      0, (sum, item) => sum + (item.product.price * item.quantity.value));

  double get deliveryFee => 0.0; // Example fixed delivery fee

  double get total => subtotal + deliveryFee;
 

  CartController() {
    _loadCartFromStorage();
  }

  void addToCart(Product product) {
    final existingItemIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);
    if (existingItemIndex != -1) {
      cartItems[existingItemIndex].incrementQuantity();
    } else {
      cartItems.add(CartItem(product: product));
    }
    _saveCartToStorage();
    update();
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
    _saveCartToStorage();
    update();
  }

  void increaseQuantity(CartItem item) {
    item.incrementQuantity();
    _saveCartToStorage();
    update();
  }

  void decreaseQuantity(CartItem item) {
    item.decrementQuantity();
    if (item.quantity.value == 0) {
      removeFromCart(item);
    } else {
      _saveCartToStorage();
      update();
    }
  }

  void clearCart() {
    cartItems.clear();
    _saveCartToStorage();
    update();
  }

  void _saveCartToStorage() {
    final cartJson = cartItems.map((item) => item.toJson()).toList();
    _storage.write('cart', json.encode(cartJson));
  }

  void _loadCartFromStorage() {
    final cartJson = _storage.read('cart');
    if (cartJson != null) {
      final List<dynamic> decodedJson = json.decode(cartJson);
      cartItems.value =
          decodedJson.map((item) => CartItem.fromJson(item)).toList();
    }
  }

  void proceedToCheckout() {

    Get.toNamed('/addresses');
  }
}
