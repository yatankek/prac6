import 'package:prac6/features/menu/data/models/dish_model.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';

class FavoritesRepository {
  final MenuRepository _menuRepository;
  final List<String> _favoriteIds = ['1', '5'];

  FavoritesRepository(this._menuRepository);

  List<Dish> getFavorites() {
    return _favoriteIds.map((id) => _menuRepository.getDishById(id)).toList();
  }
}