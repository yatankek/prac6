import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleTheme() {
    final newThemeMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    emit(state.copyWith(themeMode: newThemeMode));
  }

  void setNotifications(bool enabled) {
    emit(state.copyWith(notificationsEnabled: enabled));
  }

  void setSoundEffects(bool enabled) {
    emit(state.copyWith(soundEffectsEnabled: enabled));
  }

  void setLanguage(String language) {
    emit(state.copyWith(language: language));
  }

  void setCurrency(String currency) {
    emit(state.copyWith(currency: currency));
  }
}