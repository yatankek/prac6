import 'package:bloc/bloc.dart';
import 'package:prac6/features/menu/data/bloc/dish_detail/dish_detail_state.dart';
import 'package:prac6/features/menu/data/models/dish_model.dart';
import 'package:prac6/features/menu/data/repositories/cart_repository.dart';
import 'package:prac6/features/menu/data/repositories/favorites_repository.dart';
import 'package:prac6/core/di/service_locator.dart';

class DishDetailCubit extends Cubit<DishDetailState> {
  final CartRepository _cartRepository;
  final FavoritesRepository _favoritesRepository;

  DishDetailCubit()
      : _cartRepository = getIt<CartRepository>(),
        _favoritesRepository = getIt<FavoritesRepository>(),
        super(const DishDetailState());

  void loadDish(Dish dish) {
    emit(state.copyWith(isLoading: true));

    final isFavorite = _favoritesRepository.isFavorite(dish.id);
    final isInCart = _cartRepository.isInCart(dish.id);

    emit(DishDetailState(
      dish: dish,
      isFavorite: isFavorite,
      isInCart: isInCart,
      isLoading: false,
    ));
  }

  void toggleFavorite() {
    if (state.dish != null) {
      if (state.isFavorite) {
        _favoritesRepository.removeFromFavorites(state.dish!.id);
      } else {
        _favoritesRepository.addToFavorites(state.dish!.id);
      }

      emit(state.copyWith(
        isFavorite: !state.isFavorite,
      ));
    }
  }

  void toggleCart() {
    if (state.dish != null) {
      if (state.isInCart) {
        _cartRepository.removeFromCart(state.dish!.id);
      } else {
        _cartRepository.addToCart(state.dish!.id);
      }

      emit(state.copyWith(
        isInCart: !state.isInCart,
      ));
    }
  }
}