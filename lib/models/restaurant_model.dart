class RestaurantModel {
  final String id;
  final String name;
  final String address;
  final String description;
  final String imageUrl;
  final double rating;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.imageUrl,
    this.rating = 4.0, // Default rating
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'].toString(),
      name: json['nome'] ?? '',
      address: json['endereco'] ?? '',
      description: json['descricao'] ?? '',
      imageUrl: json['imagem'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': name,
      'endereco': address,
      'descricao': description,
      'imagem': imageUrl,
      'rating': rating,
    };
  }
}
