class Product {
  final String title;
  final String videoUrl;
  final double price;
  final double originalPrice;
  final String image;
  bool? isApproved;

  Product({
    required this.title,
    required this.videoUrl,
    required this.price,
    required this.originalPrice,
    required this.image,
    this.isApproved,
  });
}