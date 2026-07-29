class ReviewModel {
  final String id;
  final String productId;
  final String productTitle;
  final List<String> productPhotos;
  final String userId;
  final String firstName;
  final String lastName;
  final String? avatarUrl;
  final double rating;
  final String comment;
  final String createdAt;

  ReviewModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productPhotos,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic>json){
    final product = json['product'] ?? {};
    final user = json['user'] ?? {};
    return ReviewModel(
      id: json['_id'] ?? '',
      productId: product['_id'] ?? '',
      productTitle: product['title'] ?? '',
      productPhotos: List<String>.from(product['photos'] ?? []),
      userId: user['_id'] ?? '',
      firstName: user['first_name'] ?? '',
      lastName: user['last_name'] ?? '',
      avatarUrl: user['avatar_url'],
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}