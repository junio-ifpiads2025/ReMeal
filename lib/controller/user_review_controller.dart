// user_review_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_review.dart';
import '../utils/preferences.dart';
import 'package:remeal/controller/auth_provider.dart'; // Importar AuthControllerProvider

class UserReviewController extends AsyncNotifier<List<UserReview>> {
  
  @override
  Future<List<UserReview>> build() async {
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      loading: () => [],
      error: (err, st) => throw err,
      data: (user) async {
        if (user == null) {
          return [];
        }
        // pega as reviews usando o ID do usuário
        final List<Map<String, dynamic>> reviewsJson = await Preferences.getUserReviews(user.id);
        return reviewsJson.map((json) => UserReview.fromJson(json)).toList();
      },
    );
  }

  Future<void> addReview(UserReview newReview) async {
    final user = ref.read(authControllerProvider).value;
    
    if (user == null) {
        return;
    }
    final userId = user.id;

    final currentReviews = state.value ?? [];

    final updatedReviews = [newReview, ...currentReviews];
    
    state = AsyncValue.data(updatedReviews);

    final reviewsJson = updatedReviews.map((review) => review.toJson()).toList();

    await Preferences.saveUserReviews(userId, reviewsJson);
  }

}

final userReviewControllerProvider = 
    AsyncNotifierProvider<UserReviewController, List<UserReview>>(
  () => UserReviewController(),
);