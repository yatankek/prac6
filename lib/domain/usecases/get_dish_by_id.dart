import 'package:prac6/core/models/dish.dart';
import 'package:prac6/domain/repositories/menu_repository.dart';

/// Use Case: Получить блюдо по ID
class GetDishById {
  final MenuRepository _menuRepository;

  GetDishById(this._menuRepository);

  Future<Dish> call(String id) {
    return _menuRepository.getDishById(id);
  }
}



