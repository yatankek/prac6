import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:prac6/domain/repositories/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository;

  SettingsCubit(this._repository) : super(const SettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final themeMode = await _repository.getThemeMode();
    final notifications = await _repository.getNotificationsEnabled();
    final soundEffects = await _repository.getSoundEffectsEnabled();
    final language = await _repository.getLanguage();
    final currency = await _repository.getCurrency();

    emit(state.copyWith(
      themeMode: themeMode,
      notificationsEnabled: notifications,
      soundEffectsEnabled: soundEffects,
      language: language,
      currency: currency,
    ));
  }

  Future<void> toggleTheme() async {
    final newThemeMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    await _repository.setThemeMode(newThemeMode);
    emit(state.copyWith(themeMode: newThemeMode));
  }

  Future<void> setNotifications(bool enabled) async {
    await _repository.setNotificationsEnabled(enabled);
    emit(state.copyWith(notificationsEnabled: enabled));
  }

  Future<void> setSoundEffects(bool enabled) async {
    await _repository.setSoundEffectsEnabled(enabled);
    emit(state.copyWith(soundEffectsEnabled: enabled));
  }

  Future<void> setLanguage(String language) async {
    await _repository.setLanguage(language);
    emit(state.copyWith(language: language));
  }

  Future<void> setCurrency(String currency) async {
    await _repository.setCurrency(currency);
    emit(state.copyWith(currency: currency));
  }
}
