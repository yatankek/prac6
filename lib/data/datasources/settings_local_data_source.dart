import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<void> setThemeMode(bool isDark);
  Future<bool?> getThemeMode();
  
  Future<void> setNotificationsEnabled(bool enabled);
  Future<bool?> getNotificationsEnabled();

  Future<void> setSoundEffectsEnabled(bool enabled);
  Future<bool?> getSoundEffectsEnabled();

  Future<void> setLanguage(String language);
  Future<String?> getLanguage();

  Future<void> setCurrency(String currency);
  Future<String?> getCurrency();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  static const String _themeModeKey = 'theme_mode';
  static const String _notificationsKey = 'notifications_enabled';
  static const String _soundEffectsKey = 'sound_effects_enabled';
  static const String _languageKey = 'language';
  static const String _currencyKey = 'currency';

  @override
  Future<void> setThemeMode(bool isDark) async {
    await sharedPreferences.setBool(_themeModeKey, isDark);
  }

  @override
  Future<bool?> getThemeMode() async {
    return sharedPreferences.getBool(_themeModeKey);
  }

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    await sharedPreferences.setBool(_notificationsKey, enabled);
  }

  @override
  Future<bool?> getNotificationsEnabled() async {
    return sharedPreferences.getBool(_notificationsKey);
  }

  @override
  Future<void> setSoundEffectsEnabled(bool enabled) async {
    await sharedPreferences.setBool(_soundEffectsKey, enabled);
  }

  @override
  Future<bool?> getSoundEffectsEnabled() async {
    return sharedPreferences.getBool(_soundEffectsKey);
  }

  @override
  Future<void> setLanguage(String language) async {
    await sharedPreferences.setString(_languageKey, language);
  }

  @override
  Future<String?> getLanguage() async {
    return sharedPreferences.getString(_languageKey);
  }

  @override
  Future<void> setCurrency(String currency) async {
    await sharedPreferences.setString(_currencyKey, currency);
  }

  @override
  Future<String?> getCurrency() async {
    return sharedPreferences.getString(_currencyKey);
  }
}
