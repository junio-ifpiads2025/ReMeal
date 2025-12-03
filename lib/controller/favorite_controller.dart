import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/utils/preferences.dart';
import 'package:remeal/controller/auth_provider.dart';

class FavoriteController extends AsyncNotifier<List<int>> {
  
  @override
  Future<List<int>> build() async {
    // pega o estado de autenticação
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      loading: () => [], 
      error: (err, st) => throw err, 
      data: (user) async {
        if (user == null) {
          return []; 
        }
        return await Preferences.getFavoriteIds(user.id);
      },
    );
  }

  bool isFavorite(int id) {
    final list = state.value ?? [];
    return list.contains(id);
  }

  Future<void> toggleFavorite(int id) async {
    final user = ref.read(authControllerProvider).value;

    if (user == null) {
        return;
    }
    final userId = user.id;

    final current = state.value ?? [];

    List<int> updated;
    if (current.contains(id)) {
      updated = current.where((e) => e != id).toList();
    } else {
      updated = [...current, id];
    }

    state = AsyncValue.data(updated);
    await Preferences.setFavoriteIds(userId, updated);
  }

  Future<List<dynamic>> loadFavoriteRestaurants() async {
    final user = ref.read(authControllerProvider).value;
    final userId = user?.id;
    
    if (userId == null) {
        return [];
    }

    final jsonString = await rootBundle.loadString('lib/data/mock_data.json');
    final List<dynamic> allRestaurants = json.decode(jsonString);

    final favIds = state.value ?? []; 
    
    return allRestaurants
        .where((res) => favIds.contains(res['id']))
        .toList();
  }
}

final favoriteControllerProvider =
    AsyncNotifierProvider<FavoriteController, List<int>>(
  () => FavoriteController(),
);