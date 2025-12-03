import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_review.dart';
import '../utils/preferences.dart';

class UserReviewController extends AsyncNotifier<List<UserReview>> {
  
  @override
  Future<List<UserReview>> build() async {

    final List<Map<String, dynamic>> reviewsJson = await Preferences.getUserReviews();
    
    return reviewsJson.map((json) => UserReview.fromJson(json)).toList();
  }

  Future<void> addReview(UserReview newReview) async {
    final currentReviews = state.value ?? [];

    final updatedReviews = [newReview, ...currentReviews];
    
    state = AsyncValue.data(updatedReviews);

    final reviewsJson = updatedReviews.map((review) => review.toJson()).toList();

    await Preferences.saveUserReviews(reviewsJson);
  }

}

final userReviewControllerProvider = 
    AsyncNotifierProvider<UserReviewController, List<UserReview>>(
  () => UserReviewController(),
);