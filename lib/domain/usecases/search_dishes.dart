import 'package:prac6/core/models/dish.dart';
import 'package:prac6/domain/repositories/menu_repository.dart';

/// Use Case: Поиск блюд по запросу
class SearchDishes {
  final MenuRepository _menuRepository;

  SearchDishes(this._menuRepository);

  Future<List<Dish>> call(String query) {
    return _menuRepository.searchDishes(query);
  }
}



