import 'package:prac6/features/menu/data/models/dish_model.dart';
import 'package:prac6/features/menu/data/repositories/menu_repository.dart';

class FavoritesRepository {
  final MenuRepository _menuRepository;
  List<String> _favoriteIds = ['1', '5'];

  FavoritesRepository(this._menuRepository);

  List<Dish> getFavorites() {
    return _favoriteIds.map((id) => _menuRepository.getDishById(id)).toList();
  }

  void addToFavorites(String dishId) {
    if (!_favoriteIds.contains(dishId)) {
      _favoriteIds.add(dishId);
    }
  }

  void removeFromFavorites(String dishId) {
    _favoriteIds.remove(dishId);
  }

  bool isFavorite(String dishId) {
    return _favoriteIds.contains(dishId);
  }

  int get favoritesCount => _favoriteIds.length;
}