import 'package:prac6/core/models/dish.dart';
import 'package:prac6/data/datasources/remote/models/dish_dto.dart';

class DishMapper {
  static Dish toDomain(DishDto dto) {
    return Dish(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      price: dto.price,
      imageUrl: dto.imageUrl,
    );
  }

  static DishDto toDto(Dish dish) {
    return DishDto(
      id: dish.id,
      name: dish.name,
      description: dish.description,
      price: dish.price,
      imageUrl: dish.imageUrl,
    );
  }

  static List<Dish> toDomainList(List<DishDto> dtos) {
    return dtos.map((dto) => toDomain(dto)).toList();
  }

  static List<DishDto> toDtoList(List<Dish> dishes) {
    return dishes.map((dish) => toDto(dish)).toList();
  }
}
