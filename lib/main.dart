import 'package:flutter/material.dart';
import 'package:prac6/features/menu/presentation/screens/menu_screen.dart';

void main() {
  runApp(const RestaurantMenuApp());
}

class RestaurantMenuApp extends StatelessWidget {
  const RestaurantMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Меню Ресторана',
      theme: ThemeData(primaryColor: const Color(0xFFD32F2F)),
      home: MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}