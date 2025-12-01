import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/utils/preferences.dart';

// Notifier para controlar a categoria
class CategoryNotifier extends Notifier<String?> {
  @override
  String? build() {
    _loadCategory();
    return null; // valor inicial
  }

  void _loadCategory() async {
    final category = await Preferences.getLastCategory();
    state = category;
  }

  Future<void> setCategory(String category) async {
    state = category;
    await Preferences.setLastCategory(category);
  }
}

// Provider para a categoria
final categoryProvider = NotifierProvider<CategoryNotifier, String?>(() => CategoryNotifier());