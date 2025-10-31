class Dish {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  String get formattedPrice => '$price ₽';
}