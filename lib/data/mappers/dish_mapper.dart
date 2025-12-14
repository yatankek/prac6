import 'package:prac6/core/models/dish.dart';
import 'package:prac6/data/dtos/dish_dto.dart';

/// Mapper для преобразования между DTO и бизнес-моделями
/// Изолирует логику трансформации данных
class DishMapper {
  /// Преобразование DTO в бизнес-модель
  static Dish toDomain(DishDto dto) {
    return Dish(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      price: dto.price,
      imageUrl: dto.imageUrl,
    );
  }

  /// Преобразование бизнес-модели в DTO
  static DishDto toDto(Dish dish) {
    return DishDto(
      id: dish.id,
      name: dish.name,
      description: dish.description,
      price: dish.price,
      imageUrl: dish.imageUrl,
    );
  }

  /// Преобразование списка DTO в список моделей
  static List<Dish> toDomainList(List<DishDto> dtos) {
    return dtos.map((dto) => toDomain(dto)).toList();
  }

  /// Преобразование списка моделей в список DTO
  static List<DishDto> toDtoList(List<Dish> dishes) {
    return dishes.map((dish) => toDto(dish)).toList();
  }
}

