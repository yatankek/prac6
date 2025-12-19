import 'package:flutter/foundation.dart';
import 'package:prac6/core/models/dish.dart';

class FavoritesState {
  final List<Dish> favorites;
  final int favoriteCount;
  final bool isLoading;

  const FavoritesState({
    this.favorites = const [],
    this.favoriteCount = 0,
    this.isLoading = false,
  });

  FavoritesState copyWith({
    List<Dish>? favorites,
    int? favoriteCount,
    bool? isLoading,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoritesState &&
        listEquals(other.favorites, favorites) &&
        other.favoriteCount == favoriteCount &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode => favorites.hashCode ^ favoriteCount.hashCode ^ isLoading.hashCode;
}

