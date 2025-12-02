import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/utils/preferences.dart';

// Notifier para controlar a categoria
class CategoryNotifier extends Notifier<String?> {
  @override
  String? build() {
    // Carrega a categoria de forma síncrona inicialmente
    _loadCategory();
    return null;
  }

  void _loadCategory() async {
    final category = await Preferences.getLastCategory();
    if (category != null && category.isNotEmpty) {
        Future.microtask(() => state = category);
      }
  }

  Future<void> setCategory(String? category) async {
    state = category;
    if (category != null && category.isNotEmpty) {
        await Preferences.setLastCategory(category);
      } else {
        await Preferences.setLastCategory('');
      }
  }

  Future<void> clearFilter() async {
    state = null;
    await Preferences.setLastCategory('');
  }
}

// Provider para a categoria
final categoryProvider = NotifierProvider<CategoryNotifier, String?>(() => CategoryNotifier());

// Notifier para controlar a pesquisa
class SearchNotifier extends Notifier<String> {
  @override
  String build() {
    return ''; // valor inicial vazio
  }

  void setSearchQuery(String query) {
    state = query;
  }

  void clearSearch() {
    state = '';
  }
}

// Provider para a pesquisa
final searchProvider = NotifierProvider<SearchNotifier, String>(() => SearchNotifier());