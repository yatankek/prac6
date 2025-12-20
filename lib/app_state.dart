import 'package:flutter/material.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/domain/repositories/cart_repository.dart';
import 'package:prac6/domain/repositories/favorites_repository.dart';

class AppState extends InheritedWidget {
  final int favoriteCount;
  final int cartItemsCount;
  final Future<void> Function() refreshUI;

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

  Future<void> _refreshUI() async {
    final favorites = await getIt<FavoritesRepository>().getFavorites();
    final cartItems = await getIt<CartRepository>().getCartItems();
    setState(() {
      _favoriteCount = favorites.length;
      _cartItemsCount = cartItems.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    final favorites = await getIt<FavoritesRepository>().getFavorites();
    final cartItems = await getIt<CartRepository>().getCartItems();
    setState(() {
      _favoriteCount = favorites.length;
      _cartItemsCount = cartItems.length;
    });
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