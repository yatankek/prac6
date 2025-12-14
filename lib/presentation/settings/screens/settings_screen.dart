import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac6/presentation/settings/bloc/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView(
            children: [
              // Раздел Внешний вид
              _buildSectionHeader('Внешний вид'),
              _buildListTile(
                title: 'Тема приложения',
                subtitle: state.themeMode == ThemeMode.light ? 'Светлая' : 'Тёмная',
                icon: Icons.brightness_6,
                trailing: Switch(
                  value: state.themeMode == ThemeMode.dark,
                  onChanged: (_) {
                    context.read<SettingsCubit>().toggleTheme();
                  },
                  activeColor: const Color(0xFFD32F2F),
                ),
                onTap: () {
                  context.read<SettingsCubit>().toggleTheme();
                },
              ),

              _buildSectionHeader('Уведомления'),
              _buildListTile(
                title: 'Уведомления',
                subtitle: state.notificationsEnabled ? 'Включены' : 'Выключены',
                icon: Icons.notifications,
                trailing: Switch(
                  value: state.notificationsEnabled,
                  onChanged: (value) {
                    context.read<SettingsCubit>().setNotifications(value);
                  },
                  activeColor: const Color(0xFFD32F2F),
                ),
              ),
              _buildListTile(
                title: 'Звуковые эффекты',
                subtitle: state.soundEffectsEnabled ? 'Включены' : 'Выключены',
                icon: Icons.volume_up,
                trailing: Switch(
                  value: state.soundEffectsEnabled,
                  onChanged: (value) {
                    context.read<SettingsCubit>().setSoundEffects(value);
                  },
                  activeColor: const Color(0xFFD32F2F),
                ),
              ),

              // Раздел Язык и валюта
              _buildSectionHeader('Язык и валюта'),
              _buildListTile(
                title: 'Язык',
                subtitle: state.language,
                icon: Icons.language,
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  _showLanguageDialog(context);
                },
              ),
              _buildListTile(
                title: 'Валюта',
                subtitle: state.currency == 'RUB' ? 'Рубль (₽)' : 'Доллар (\$)',
                icon: Icons.monetization_on,
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  _showCurrencyDialog(context);
                },
              ),

              // Раздел О приложении
              _buildSectionHeader('О приложении'),
              _buildListTile(
                title: 'Версия приложения',
                subtitle: '1.0.0',
                icon: Icons.info,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('О приложении'),
                      content: const Text(
                        'Ресторанное приложение v1.0.0\n\n'
                            'Разработано для удобного заказа блюд из меню ресторана.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              _buildListTile(
                title: 'Политика конфиденциальности',
                subtitle: 'Читать',
                icon: Icons.privacy_tip,
                onTap: () {
                  // В будущем можно добавить экран с политикой
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Политика конфиденциальности'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD32F2F)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите язык'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Русский'),
                leading: const Icon(Icons.language),
                onTap: () {
                  context.read<SettingsCubit>().setLanguage('Русский');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('English'),
                leading: const Icon(Icons.language),
                onTap: () {
                  context.read<SettingsCubit>().setLanguage('English');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCurrencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите валюту'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Рубль (₽)'),
                leading: const Icon(Icons.currency_ruble),
                onTap: () {
                  context.read<SettingsCubit>().setCurrency('RUB');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Доллар (\$)'),
                leading: const Icon(Icons.attach_money),
                onTap: () {
                  context.read<SettingsCubit>().setCurrency('USD');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
