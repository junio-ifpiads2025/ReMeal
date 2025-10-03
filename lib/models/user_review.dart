class UserReview {
  final String id;
  final String restaurantName;
  final String imageUrl;
  final double rating;
  final String comment;
  final String date;

  UserReview({
    required this.id,
    required this.restaurantName,
    required this.imageUrl,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory UserReview.fromJson(Map<String, dynamic> json) {
    return UserReview(
      id: json['id'] as String,
      restaurantName: json['restaurantName'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'imageUrl': imageUrl,
      'rating': rating,
      'comment': comment,
      'date': date,
    };
  }
}
