class Plan {
  final String name;
  final String description;
  final String quantity;
  final double price;
  final String duration;
  final bool isPopular;

  Plan({
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.duration,
    this.isPopular = false,
  });
}
