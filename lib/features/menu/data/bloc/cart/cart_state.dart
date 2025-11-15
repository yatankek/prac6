import 'package:flutter/foundation.dart';
import 'package:prac6/features/menu/data/models/dish_model.dart';

class CartState {
  final List<Dish> cartItems;
  final double totalPrice;
  final int itemCount;
  final bool isLoading;

  const CartState({
    this.cartItems = const [],
    this.totalPrice = 0,
    this.itemCount = 0,
    this.isLoading = false,
  });

  CartState copyWith({
    List<Dish>? cartItems,
    double? totalPrice,
    int? itemCount,
    bool? isLoading,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      itemCount: itemCount ?? this.itemCount,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartState &&
        listEquals(other.cartItems, cartItems) &&
        other.totalPrice == totalPrice &&
        other.itemCount == itemCount &&
        other.isLoading == isLoading;
  }
  @override
  int get hashCode =>
      cartItems.hashCode ^ totalPrice.hashCode ^ itemCount.hashCode ^ isLoading.hashCode;
}