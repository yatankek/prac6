import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:prac6/app_state.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/core/observer/counter_observer.dart';
import 'core/routing/app_router.dart';

void main() {
  setupServiceLocator();
  Bloc.observer = const CounterObserver();
  runApp(const RestaurantMenuApp());
}

class RestaurantMenuApp extends StatelessWidget {
  const RestaurantMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateContainer(
      child: MaterialApp.router(
        title: 'Ресторанное приложение',
        theme: ThemeData(
          primaryColor: const Color(0xFFD32F2F),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFD32F2F),
            foregroundColor: Colors.white,
          ),
        ),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}