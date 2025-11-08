import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'service_locator.dart';
import 'app_state.dart';

void main() {
  setupServiceLocator();
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