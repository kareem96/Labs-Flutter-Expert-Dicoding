class ProductDetails {
  final String image;
  final String name;
  final String description;
  final String age;
  final bool isMale;
  final String distance;

  ProductDetails({
    required this.image,
    required this.name,
    required this.description,
    required this.age,
    required this.isMale,
    required this.distance,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
        image: json['image'],
        name: json['name'],
        description: json['description'],
        age: json['age'],
        isMale: json['isMale'],
        distance: json['distance']);
  }
}
