import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String themeKey = 'isDarkMode';
  static const String categoryKey = 'lastCategory';

  // salva um boolean para indicar se o dark mode está ativado
  static Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDark);
  }

  // recupera o valor do dark mode
  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey) ?? false;
  }

  // salva uma string para a ultima categoria
  static Future<void> setLastCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(categoryKey, category);
  }

  // recupera a string da ultima categoria
  static Future<String?> getLastCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(categoryKey);
  }
}