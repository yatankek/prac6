import 'package:prac6/domain/repositories/favorites_repository.dart';

/// Use Case: Добавить блюдо в избранное
class AddToFavorites {
  final FavoritesRepository _favoritesRepository;

  AddToFavorites(this._favoritesRepository);

  Future<void> call(String dishId) {
    return _favoritesRepository.addToFavorites(dishId);
  }
}

