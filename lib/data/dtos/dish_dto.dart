/// Data Transfer Object для блюда
/// Соответствует формату внешнего источника данных (JSON, API и т.д.)
class DishDto {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const DishDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  /// Создание из JSON (если данные приходят из API)
  factory DishDto.fromJson(Map<String, dynamic> json) {
    return DishDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );
  }

  /// Преобразование в JSON (для отправки в API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

