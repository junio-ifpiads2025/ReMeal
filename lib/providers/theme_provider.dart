import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/utils/preferences.dart';

// Notifier para controlar o tema
class ThemeNotifier extends Notifier<bool> {
  @override
  bool build() {
    _loadTheme();
    return false; // valor inicial
  }

  void _loadTheme() async {
    final isDark = await Preferences.getDarkMode();
    state = isDark;
  }

  Future<void> setDarkMode(bool isDark) async {
    state = isDark;
    await Preferences.setDarkMode(isDark);
  }
}

// Provider para o tema
final themeProvider = NotifierProvider<ThemeNotifier, bool>(() => ThemeNotifier());