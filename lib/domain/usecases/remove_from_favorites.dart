import 'package:prac6/domain/repositories/favorites_repository.dart';

/// Use Case: Удалить блюдо из избранного
class RemoveFromFavorites {
  final FavoritesRepository _favoritesRepository;

  RemoveFromFavorites(this._favoritesRepository);

  Future<void> call(String dishId) {
    return _favoritesRepository.removeFromFavorites(dishId);
  }
}

