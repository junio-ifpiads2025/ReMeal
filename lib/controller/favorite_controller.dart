import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/utils/preferences.dart';

class FavoriteController extends AsyncNotifier<List<int>> {
  @override
  Future<List<int>> build() async {
    return await Preferences.getFavoriteIds();
  }

  bool isFavorite(int id) {
    final list = state.value ?? [];
    return list.contains(id);
  }

  Future<void> toggleFavorite(int id) async {
    final current = state.value ?? [];

    List<int> updated;
    if (current.contains(id)) {
      updated = current.where((e) => e != id).toList();
    } else {
      updated = [...current, id];
    }

    state = AsyncValue.data(updated);
    await Preferences.setFavoriteIds(updated);
  }

  Future<List<dynamic>> loadFavoriteRestaurants() async {
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
