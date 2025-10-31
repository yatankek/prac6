import 'package:prac6/features/menu/data/models/dish_model.dart';

class MenuRepository {
  final List<Dish> _dishes = const [
    Dish(
      id: '1',
      name: 'Паста Карбонара',
      description: 'Спагетти с беконом, сливочным соусом и пармезаном',
      price: 890,
      imageUrl: 'http://patee.ru/r/x6/11/70/8e/960m.jpg',
    ),
    Dish(
      id: '2',
      name: 'Пицца Маргарита',
      description: 'Томатный соус, моцарелла и свежий базилик',
      price: 750,
      imageUrl: 'https://cdn.vkuso.ru/uploads/116430_domashnyaya-picca-margarita-s-mocarelloj-i-parmezanom_1649094920.jpg',
    ),
    Dish(
      id: '3',
      name: 'Стейк Рибай',
      description: 'Мраморная говядина с овощами-гриль и соусом',
      price: 1850,
      imageUrl: 'https://inde.io/wp-content/uploads/2025/08/d584ff23f6b72413d8cfa7a1e8dd16af.jpg',
    ),
    Dish(
      id: '4',
      name: 'Салат Цезарь',
      description: 'Листья айсберг, курица-гриль и соус цезарь',
      price: 450,
      imageUrl: 'https://img.iamcook.ru/2024/upl/recipes/zen/u-b407678da66810be60c6a8e246a76ea1.JPG',
    ),
    Dish(
      id: '5',
      name: 'Тирамису',
      description: 'Кофейный десерт с сыром маскарпоне',
      price: 380,
      imageUrl: 'https://art-lunch.ru/content/uploads/2014/10/Tiramisu.jpg',
    ),
  ];

  List<Dish> getAllDishes() => List.unmodifiable(_dishes);

  Dish getDishById(String id) =>
      _dishes.firstWhere((dish) => dish.id == id);
}