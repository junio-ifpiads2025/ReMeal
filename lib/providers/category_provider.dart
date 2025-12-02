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
    try {
      final category = await Preferences.getLastCategory();
      print('🔄 Categoria carregada das preferências: "$category"');
      if (category != null && category.isNotEmpty) {
        print('📱 Atualizando state para: "$category"');
        // Usar Future.microtask para garantir que o state seja atualizado corretamente
        Future.microtask(() => state = category);
      }
    } catch (e) {
      print('❌ Erro ao carregar categoria: $e');
    }
  }

  Future<void> setCategory(String? category) async {
    try {
      print('🎯 Definindo categoria: "$category"');
      // Atualiza o state imediatamente
      state = category;
      
      if (category != null && category.isNotEmpty) {
        await Preferences.setLastCategory(category);
        print('💾 Categoria salva: "$category"');
      } else {
        await Preferences.setLastCategory('');
        print('🗑️ Categoria limpa');
      }
    } catch (e) {
      print('❌ Erro ao definir categoria: $e');
    }
  }

  Future<void> clearFilter() async {
    try {
      print('🧹 Limpando filtro de categoria');
      state = null;
      await Preferences.setLastCategory('');
    } catch (e) {
      print('❌ Erro ao limpar categoria: $e');
    }
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