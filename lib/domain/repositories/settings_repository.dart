import 'package:flutter/material.dart';

abstract class SettingsRepository {
  Future<void> setThemeMode(ThemeMode themeMode);
  Future<ThemeMode> getThemeMode();
  
  Future<void> setNotificationsEnabled(bool enabled);
  Future<bool> getNotificationsEnabled();

  Future<void> setSoundEffectsEnabled(bool enabled);
  Future<bool> getSoundEffectsEnabled();

  Future<void> setLanguage(String language);
  Future<String> getLanguage();

  Future<void> setCurrency(String currency);
  Future<String> getCurrency();
}
