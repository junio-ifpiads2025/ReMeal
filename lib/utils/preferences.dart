import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Preferences {
  static const String themeKey = 'isDarkMode';
  static const String categoryKey = 'lastCategory';
  static const String searchHistoryKey = 'searchHistory'; 
  
  static String _getFavoritesKey(String userId) => 'favoriteRestaurants_$userId';
  static String _getReviewsKey(String userId) => 'userReviews_$userId';

  static Future<void> saveSearchHistory(List<String> history) async {
    final prefs = await SharedPreferences.getInstance();
    final limitedHistory = history.take(3).toList(); 
    await prefs.setStringList(searchHistoryKey, limitedHistory);
  }
  static Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(searchHistoryKey) ?? [];
  }
  
  static Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDark);
  }
  
  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey) ?? false;
  }
  
  static Future<void> setLastCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(categoryKey, category);
  }
  
  static Future<String?> getLastCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(categoryKey);
  }
  
  static Future<void> setFavoriteIds(String userId, List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    final idsStr = ids.map((e) => e.toString()).toList();
    await prefs.setStringList(_getFavoritesKey(userId), idsStr);
  }
  
  static Future<List<int>> getFavoriteIds(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final idsStr = prefs.getStringList(_getFavoritesKey(userId)) ?? [];
    return idsStr.map(int.parse).toList();
  }
  
  static List<int> getFavoriteListSync() {
    throw Exception("getFavoriteListSync precisa ser assíncrono!");
  }
  
  static Future<void> saveFavoriteList(String userId, List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = ids.map((e) => e.toString()).toList();
    await prefs.setStringList(_getFavoritesKey(userId), stringList);
  }
  static Future<void> saveUserReviews(String userId, List<Map<String, dynamic>> reviewsJson) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = json.encode(reviewsJson); 
    await prefs.setString(_getReviewsKey(userId), jsonString);
  }

  static Future<List<Map<String, dynamic>>> getUserReviews(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_getReviewsKey(userId));
    
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.cast<Map<String, dynamic>>(); 
  }
}