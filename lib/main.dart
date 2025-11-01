import 'package:flutter/material.dart';
import 'package:prac6/features/menu/presentation/screens/auth_screen.dart';

void main() {
  runApp(const RestaurantMenuApp());
}

class RestaurantMenuApp extends StatelessWidget {
  const RestaurantMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ресторанное приложение',
      theme: ThemeData(
        primaryColor: const Color(0xFFD32F2F),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: Colors.white,
        ),
      ),
      home: const AuthScreen(), // Начинаем с экрана авторизации
      debugShowCheckedModeBanner: false,
    );
  }
}