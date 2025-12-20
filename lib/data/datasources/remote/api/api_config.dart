class ApiConfig {
  static const String mealDbBaseUrl = 'https://www.themealdb.com/api/json/v1/1';
  static const String randomUserBaseUrl = 'https://randomuser.me/api';
  
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
}
