class ProductModel {
  final String id;
  final String title;
  final List<String> photos;
  final int price;
  final double rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.photos,
    required this.price,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic>jsonData){
    return ProductModel(
        id: jsonData['_id'],
        title: jsonData['title'],
        photos: List.from(jsonData['photos']),
        price: jsonData['current_price'],
        rating: 4.0,
    );
  }
}
