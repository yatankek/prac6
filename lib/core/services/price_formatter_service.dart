import 'package:prac6/core/constants/app_constants.dart';

/// Сервис для форматирования цен
/// Чистая бизнес-логика без зависимостей от Flutter
class PriceFormatterService {
  /// Форматирует цену с символом валюты
  static String formatPrice(double price) {
    return '$price ${AppConstants.currencySymbol}';
  }

  /// Вычисляет общую стоимость списка блюд
  static double calculateTotal(List<double> prices) {
    return prices.fold(0.0, (sum, price) => sum + price);
  }

  /// Форматирует общую стоимость
  static String formatTotal(List<double> prices) {
    final total = calculateTotal(prices);
    return formatPrice(total);
  }
}

