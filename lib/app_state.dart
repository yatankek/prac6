import 'package:flutter/material.dart';
import 'package:prac6/features/menu/data/repositories/cart_repository.dart';
import 'package:prac6/features/menu/data/repositories/favorites_repository.dart';
import 'package:prac6/core/di/service_locator.dart';

class AppState extends InheritedWidget {
  final int favoriteCount;
  final int cartItemsCount;
  final VoidCallback refreshUI;

  const AppState({
    super.key,
    required super.child,
    required this.favoriteCount,
    required this.cartItemsCount,
    required this.refreshUI,
  });

  static AppState of(BuildContext context) {
    final AppState? result = context.dependOnInheritedWidgetOfExactType<AppState>();
    assert(result != null, 'No AppState found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppState oldWidget) {
    return favoriteCount != oldWidget.favoriteCount ||
        cartItemsCount != oldWidget.cartItemsCount;
  }
}

class AppStateContainer extends StatefulWidget {
  final Widget child;

  const AppStateContainer({super.key, required this.child});

  @override
  State<AppStateContainer> createState() => _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer> {
  int _favoriteCount = 0;
  int _cartItemsCount = 0;

  void _refreshUI() {
    setState(() {
      _favoriteCount = getIt<FavoritesRepository>().getFavorites().length;
      _cartItemsCount = getIt<CartRepository>().getCartItems().length;
    });
  }

  @override
  void initState() {
    super.initState();
    _favoriteCount = getIt<FavoritesRepository>().getFavorites().length;
    _cartItemsCount = getIt<CartRepository>().getCartItems().length;
  }

  @override
  Widget build(BuildContext context) {
    return AppState(
      favoriteCount: _favoriteCount,
      cartItemsCount: _cartItemsCount,
      refreshUI: _refreshUI,
      child: widget.child,
    );
  }
}