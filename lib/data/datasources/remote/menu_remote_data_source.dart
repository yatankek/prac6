import 'package:dio/dio.dart';
import 'package:prac6/data/datasources/remote/api/api_config.dart';
import 'package:prac6/core/models/dish.dart';

abstract class MenuRemoteDataSource {
  Future<List<Dish>> searchDishes(String query);
  Future<List<Dish>> getDishesByCategory(String category);
  Future<Dish> getDishById(String id);
  Future<List<String>> getCategories();
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  final Dio _dio;

  MenuRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Dish>> searchDishes(String query) async {
    final response = await _dio.get(
      '${ApiConfig.mealDbBaseUrl}/search.php',
      queryParameters: {'s': query},
    );

    if (response.data['meals'] == null) return [];

    return (response.data['meals'] as List)
        .map((e) => _mapMealToDish(e))
        .toList();
  }

  @override
  Future<List<Dish>> getDishesByCategory(String category) async {
    final response = await _dio.get(
      '${ApiConfig.mealDbBaseUrl}/filter.php',
      queryParameters: {'c': category},
    );

    if (response.data['meals'] == null) return [];

    return (response.data['meals'] as List)
        .map((e) => _mapMealToDish(e))
        .toList();
  }

  @override
  Future<Dish> getDishById(String id) async {
    final response = await _dio.get(
      '${ApiConfig.mealDbBaseUrl}/lookup.php',
      queryParameters: {'i': id},
    );

    final meals = response.data['meals'] as List?;
    if (meals == null || meals.isEmpty) {
      throw Exception('Блюдо не найдено');
    }

    return _mapMealToDish(meals.first);
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await _dio.get('${ApiConfig.mealDbBaseUrl}/categories.php');
    
    if (response.data['categories'] == null) return [];

    return (response.data['categories'] as List)
        .map((e) => e['strCategory'] as String)
        .toList();
  }

  Dish _mapMealToDish(Map<String, dynamic> json) {
    final id = json['idMeal'] as String;
    final price = 300.0 + (int.parse(id) % 100) * 10; 

    return Dish(
      id: id,
      name: json['strMeal'] ?? '',
      description: json['strInstructions'] ?? 'Вкусное блюдо',
      price: price,
      imageUrl: json['strMealThumb'] ?? '',
    );
  }
}
