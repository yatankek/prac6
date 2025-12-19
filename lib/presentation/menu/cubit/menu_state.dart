import 'package:flutter/foundation.dart';
import 'package:prac6/core/models/dish.dart';

class MenuState {
  final List<Dish> dishes;
  final List<Dish> filteredDishes;
  final String searchQuery;
  final bool isLoading;

  const MenuState({
    this.dishes = const [],
    this.filteredDishes = const [],
    this.searchQuery = '',
    this.isLoading = true,
  });

  List<Dish> get displayDishes =>
      filteredDishes.isNotEmpty ? filteredDishes : dishes;

  MenuState copyWith({
    List<Dish>? dishes,
    List<Dish>? filteredDishes,
    String? searchQuery,
    bool? isLoading,
  }) {
    return MenuState(
      dishes: dishes ?? this.dishes,
      filteredDishes: filteredDishes ?? this.filteredDishes,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MenuState &&
        listEquals(other.dishes, dishes) &&
        listEquals(other.filteredDishes, filteredDishes) &&
        other.searchQuery == searchQuery &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode =>
      dishes.hashCode ^ filteredDishes.hashCode ^ searchQuery.hashCode ^ isLoading.hashCode;
}

