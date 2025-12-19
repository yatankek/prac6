import 'package:bloc/bloc.dart';
import 'package:prac6/core/models/dish.dart';
import 'package:prac6/presentation/menu/cubit/dish_detail_state.dart';
import 'package:prac6/domain/usecases/check_is_favorite.dart';
import 'package:prac6/domain/usecases/add_to_favorites.dart';
import 'package:prac6/domain/usecases/remove_from_favorites.dart';
import 'package:prac6/domain/usecases/add_to_cart.dart';
import 'package:prac6/domain/usecases/remove_from_cart.dart';
import 'package:prac6/domain/usecases/get_dish_by_id.dart';
import 'package:prac6/domain/repositories/cart_repository.dart';

/// Cubit для управления состоянием деталей блюда
class DishDetailCubit extends Cubit<DishDetailState> {
  final CheckIsFavorite _checkIsFavorite;
  final AddToFavorites _addToFavorites;
  final RemoveFromFavorites _removeFromFavorites;
  final AddToCart _addToCart;
  final RemoveFromCart _removeFromCart;
  final CartRepository _cartRepository;
  final GetDishById _getDishById;

  DishDetailCubit({
    required CheckIsFavorite checkIsFavorite,
    required AddToFavorites addToFavorites,
    required RemoveFromFavorites removeFromFavorites,
    required AddToCart addToCart,
    required RemoveFromCart removeFromCart,
    required CartRepository cartRepository,
    required GetDishById getDishById,
  })  : _checkIsFavorite = checkIsFavorite,
        _addToFavorites = addToFavorites,
        _removeFromFavorites = removeFromFavorites,
        _addToCart = addToCart,
        _removeFromCart = removeFromCart,
        _cartRepository = cartRepository,
        _getDishById = getDishById,
        super(const DishDetailState());

  /// Загрузить детали блюда
  Future<void> loadDish(Dish initialDish) async {
    emit(state.copyWith(isLoading: true, dish: initialDish));

    try {
      final isFavorite = await _checkIsFavorite(initialDish.id);
      final isInCart = await _cartRepository.isInCart(initialDish.id);
      
      // Fetch full details from API to get description and other fields
      // that might be missing in list view (e.g. from filter by category)
      final fullDish = await _getDishById(initialDish.id);

      emit(DishDetailState(
        dish: fullDish,
        isFavorite: isFavorite,
        isInCart: isInCart,
        isLoading: false,
      ));
    } catch (e) {
      // If API fails, we still have the initial dish data
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Переключить избранное
  Future<void> toggleFavorite() async {
    if (state.dish == null) return;

    try {
      if (state.isFavorite) {
        await _removeFromFavorites(state.dish!.id);
      } else {
        await _addToFavorites(state.dish!.id);
      }

      emit(state.copyWith(isFavorite: !state.isFavorite));
    } catch (e) {
      // Обработка ошибки
    }
  }

  /// Переключить корзину
  Future<void> toggleCart() async {
    if (state.dish == null) return;

    try {
      if (state.isInCart) {
        await _removeFromCart(state.dish!.id);
      } else {
        await _addToCart(state.dish!.id);
      }

      emit(state.copyWith(isInCart: !state.isInCart));
    } catch (e) {
      // Обработка ошибки
    }
  }
}
