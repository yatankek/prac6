import 'package:flutter/foundation.dart';
import 'package:prac6/features/menu/data/models/dish_model.dart';

class CategoriesState {
  final List<Dish> dishes;
  final List<Dish> filteredDishes;
  final List<String> categories;
  final String selectedCategory;
  final bool isLoading;

  const CategoriesState({
    this.dishes = const [],
    this.filteredDishes = const [],
    this.categories = const [],
    this.selectedCategory = 'Все',
    this.isLoading = true,
  });

  List<Dish> get displayDishes =>
      filteredDishes.isNotEmpty ? filteredDishes : dishes;

  CategoriesState copyWith({
    List<Dish>? dishes,
    List<Dish>? filteredDishes,
    List<String>? categories,
    String? selectedCategory,
    bool? isLoading,
  }) {
    return CategoriesState(
      dishes: dishes ?? this.dishes,
      filteredDishes: filteredDishes ?? this.filteredDishes,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoriesState &&
        listEquals(other.dishes, dishes) &&
        listEquals(other.filteredDishes, filteredDishes) &&
        listEquals(other.categories, categories) &&
        other.selectedCategory == selectedCategory &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode =>
      dishes.hashCode ^
      filteredDishes.hashCode ^
      categories.hashCode ^
      selectedCategory.hashCode ^
      isLoading.hashCode;
}