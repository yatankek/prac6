import 'package:prac6/core/models/dish.dart';

class DishDetailState {
  final Dish? dish;
  final bool isFavorite;
  final bool isInCart;
  final bool isLoading;

  const DishDetailState({
    this.dish,
    this.isFavorite = false,
    this.isInCart = false,
    this.isLoading = true,
  });

  DishDetailState copyWith({
    Dish? dish,
    bool? isFavorite,
    bool? isInCart,
    bool? isLoading,
  }) {
    return DishDetailState(
      dish: dish ?? this.dish,
      isFavorite: isFavorite ?? this.isFavorite,
      isInCart: isInCart ?? this.isInCart,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DishDetailState &&
        other.dish == dish &&
        other.isFavorite == isFavorite &&
        other.isInCart == isInCart &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode =>
      dish.hashCode ^ isFavorite.hashCode ^ isInCart.hashCode ^ isLoading.hashCode;
}

