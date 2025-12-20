import 'package:prac6/domain/repositories/favorites_repository.dart';

/// Use Case: Проверить, является ли блюдо избранным
class CheckIsFavorite {
  final FavoritesRepository _favoritesRepository;

  CheckIsFavorite(this._favoritesRepository);

  Future<bool> call(String dishId) {
    return _favoritesRepository.isFavorite(dishId);
  }
}



