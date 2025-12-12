import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac6/app_state.dart';
import 'package:prac6/core/di/service_locator.dart';
import 'package:prac6/core/observer/counter_observer.dart';
import 'package:prac6/core/routing/app_router.dart';
import 'package:prac6/features/settings/data/bloc/settings_cubit.dart';

void main() {
  setupServiceLocator();
  Bloc.observer = const CounterObserver();
  runApp(const RestaurantMenuApp());
}

class RestaurantMenuApp extends StatelessWidget {
  const RestaurantMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: AppStateContainer(
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) {
            return MaterialApp.router(
              title: 'Ресторанное приложение',
              theme: ThemeData(
                primaryColor: const Color(0xFFD32F2F),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                ),
                brightness: Brightness.light,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFFD32F2F),
                  brightness: Brightness.light,
                ),
              ),
              darkTheme: ThemeData(
                primaryColor: const Color(0xFFD32F2F),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                ),
                brightness: Brightness.dark,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFFD32F2F),
                  brightness: Brightness.dark,
                ),
              ),
              themeMode: settingsState.themeMode,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}