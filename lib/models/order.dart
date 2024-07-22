import 'package:intl/intl.dart';

enum OrderStatus { placed, confirmed, inTransit, delivered, cancelled }

class Order {
  final String id;
  final DateTime orderDate;
  final OrderStatus status;
  final List<OrderItem> items;
  final double totalAmount;
  final String deliveryAddress;
  final DateTime? estimatedDeliveryTime;
  final String? trackingNumber;

  Order({
    required this.id,
    required this.orderDate,
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.deliveryAddress,
    this.estimatedDeliveryTime,
    this.trackingNumber,
  });

  String get formattedOrderDate => DateFormat('MMM d, y').format(orderDate);

  String get formattedStatus {
    switch (status) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.confirmed:
        return 'Order Confirmed';
      case OrderStatus.inTransit:
        return 'In Transit';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get formattedTotalAmount => '₹${totalAmount.toStringAsFixed(2)}';

  String get estimatedDeliveryTimeString {
    if (estimatedDeliveryTime == null) return 'Not available';
    return DateFormat('MMM d, y HH:mm').format(estimatedDeliveryTime!);
  }

  // Factory method to create an Order from a JSON map
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderDate: DateTime.parse(json['orderDate']),
      status: OrderStatus.values
          .firstWhere((e) => e.toString() == 'OrderStatus.${json['status']}'),
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalAmount: json['totalAmount'],
      deliveryAddress: json['deliveryAddress'],
      estimatedDeliveryTime: json['estimatedDeliveryTime'] != null
          ? DateTime.parse(json['estimatedDeliveryTime'])
          : null,
      trackingNumber: json['trackingNumber'],
    );
  }

  // Method to convert an Order to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderDate': orderDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'deliveryAddress': deliveryAddress,
      'estimatedDeliveryTime': estimatedDeliveryTime?.toIso8601String(),
      'trackingNumber': trackingNumber,
    };
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  double get totalPrice => quantity * price;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}
