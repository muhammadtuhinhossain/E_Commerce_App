class AddReviewParams {
  final String productId;
  final int rating;
  final String comment;

  AddReviewParams({
    required this.productId,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic>toJson(){
    return {
      "product": productId,
      "rating": rating,
      "comment": comment,
    };
  }
}