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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Dish &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => Object.hash(id, name, description, price, imageUrl);
}


