import 'package:get/get.dart';

class Product {
  final String id;
  final String nameKey;
  final double price;
  final String imageUrl;
  final String description;

  Product({
    required this.id,
    required this.nameKey,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  String get name => nameKey.tr;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nameKey,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '', // Provide default empty string for id
      nameKey: json['name'] ?? '', // Provide default empty string for nameKey
      price: (json['price'] as num).toDouble(), // Ensure price is double
      description: json['description'] ??
          '', // Provide default empty string for description
      imageUrl:
          json['imageUrl'] ?? '', // Provide default empty string for imageUrl
    );
  }
}
