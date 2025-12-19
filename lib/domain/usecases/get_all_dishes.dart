import 'package:prac6/core/models/dish.dart';
import 'package:prac6/domain/repositories/menu_repository.dart';

/// Use Case: Получить все блюда из меню
/// Инкапсулирует одну бизнес-операцию
class GetAllDishes {
  final MenuRepository _menuRepository;

  GetAllDishes(this._menuRepository);

  Future<List<Dish>> call() {
    return _menuRepository.getAllDishes();
  }
}



