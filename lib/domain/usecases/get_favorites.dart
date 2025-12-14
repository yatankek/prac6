import 'package:prac6/core/models/dish.dart';
import 'package:prac6/domain/repositories/favorites_repository.dart';

/// Use Case: Получить избранные блюда
class GetFavorites {
  final FavoritesRepository _favoritesRepository;

  GetFavorites(this._favoritesRepository);

  Future<List<Dish>> call() {
    return _favoritesRepository.getFavorites();
  }
}

