import 'package:bloc/bloc.dart';
import 'package:prac6/presentation/menu/cubit/favorites_state.dart';
import 'package:prac6/domain/usecases/get_favorites.dart';
import 'package:prac6/domain/usecases/add_to_favorites.dart';
import 'package:prac6/domain/usecases/remove_from_favorites.dart';
import 'package:prac6/domain/usecases/check_is_favorite.dart';

/// Cubit для управления состоянием избранного
class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavorites _getFavorites;
  final AddToFavorites _addToFavorites;
  final RemoveFromFavorites _removeFromFavorites;
  final CheckIsFavorite _checkIsFavorite;

  FavoritesCubit({
    required GetFavorites getFavorites,
    required AddToFavorites addToFavorites,
    required RemoveFromFavorites removeFromFavorites,
    required CheckIsFavorite checkIsFavorite,
  })  : _getFavorites = getFavorites,
        _addToFavorites = addToFavorites,
        _removeFromFavorites = removeFromFavorites,
        _checkIsFavorite = checkIsFavorite,
        super(const FavoritesState());

  /// Загрузить избранное
  Future<void> loadFavorites() async {
    emit(state.copyWith(isLoading: true));

    try {
      final favorites = await _getFavorites();
      emit(FavoritesState(
        favorites: favorites,
        favoriteCount: favorites.length,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Добавить в избранное
  Future<void> addToFavorites(String dishId) async {
    try {
      await _addToFavorites(dishId);
      await loadFavorites();
    } catch (e) {
      // Обработка ошибки
    }
  }

  /// Удалить из избранного
  Future<void> removeFromFavorites(String dishId) async {
    try {
      await _removeFromFavorites(dishId);
      await loadFavorites();
    } catch (e) {
      // Обработка ошибки
    }
  }

  /// Переключить избранное
  Future<void> toggleFavorite(String dishId) async {
    try {
      final isFavorite = await _checkIsFavorite(dishId);
      if (isFavorite) {
        await removeFromFavorites(dishId);
      } else {
        await addToFavorites(dishId);
      }
    } catch (e) {
      // Обработка ошибки
    }
  }
}

