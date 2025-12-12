part of 'settings_cubit.dart';

class SettingsState {
  final ThemeMode themeMode;
  final bool notificationsEnabled;
  final bool soundEffectsEnabled;
  final String language;
  final String currency;

  const SettingsState({
    this.themeMode = ThemeMode.light,
    this.notificationsEnabled = true,
    this.soundEffectsEnabled = true,
    this.language = 'Русский',
    this.currency = 'RUB',
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? notificationsEnabled,
    bool? soundEffectsEnabled,
    String? language,
    String? currency,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEffectsEnabled: soundEffectsEnabled ?? this.soundEffectsEnabled,
      language: language ?? this.language,
      currency: currency ?? this.currency,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsState &&
        other.themeMode == themeMode &&
        other.notificationsEnabled == notificationsEnabled &&
        other.soundEffectsEnabled == soundEffectsEnabled &&
        other.language == language &&
        other.currency == currency;
  }

  @override
  int get hashCode {
    return themeMode.hashCode ^
    notificationsEnabled.hashCode ^
    soundEffectsEnabled.hashCode ^
    language.hashCode ^
    currency.hashCode;
  }
}