import 'package:bloc/bloc.dart';
import 'package:prac6/features/menu/data/repositories/favorites_repository.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/features/menu/data/bloc/favorites/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesCubit()
      : _favoritesRepository = getIt<FavoritesRepository>(),
        super(const FavoritesState());

  void loadFavorites() {
    emit(state.copyWith(isLoading: true));

    final favorites = _favoritesRepository.getFavorites();

    emit(FavoritesState(
      favorites: favorites,
      favoriteCount: favorites.length,
      isLoading: false,
    ));
  }

  void addToFavorites(String dishId) {
    _favoritesRepository.addToFavorites(dishId);
    loadFavorites();
  }

  void removeFromFavorites(String dishId) {
    _favoritesRepository.removeFromFavorites(dishId);
    loadFavorites();
  }

  void toggleFavorite(String dishId) {
    if (_favoritesRepository.isFavorite(dishId)) {
      removeFromFavorites(dishId);
    } else {
      addToFavorites(dishId);
    }
  }
}