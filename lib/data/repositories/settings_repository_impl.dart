import 'package:flutter/material.dart';
import 'package:prac6/data/datasources/settings_local_data_source.dart';
import 'package:prac6/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await localDataSource.setThemeMode(themeMode == ThemeMode.dark);
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final isDark = await localDataSource.getThemeMode();
    if (isDark == null) return ThemeMode.system;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    await localDataSource.setNotificationsEnabled(enabled);
  }

  @override
  Future<bool> getNotificationsEnabled() async {
    return await localDataSource.getNotificationsEnabled() ?? true;
  }

  @override
  Future<void> setSoundEffectsEnabled(bool enabled) async {
    await localDataSource.setSoundEffectsEnabled(enabled);
  }

  @override
  Future<bool> getSoundEffectsEnabled() async {
    return await localDataSource.getSoundEffectsEnabled() ?? true;
  }

  @override
  Future<void> setLanguage(String language) async {
    await localDataSource.setLanguage(language);
  }

  @override
  Future<String> getLanguage() async {
    return await localDataSource.getLanguage() ?? 'ru';
  }

  @override
  Future<void> setCurrency(String currency) async {
    await localDataSource.setCurrency(currency);
  }

  @override
  Future<String> getCurrency() async {
    return await localDataSource.getCurrency() ?? 'RUB';
  }
}
