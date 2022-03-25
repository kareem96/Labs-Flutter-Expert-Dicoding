import 'package:ui_drawer_translation/models/product_details.dart';

class Category {
  final String title;
  final String icon;
  final List<ProductDetails> details;

  Category({
    required this.title,
    required this.icon,
    required this.details,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    List<ProductDetails> _details = [];
    if (json['details'] == null) {
      _details = [];
    } else {
      _details = json['details']
          .values
          .map<ProductDetails>(
              (jsonValue) => ProductDetails.fromJson(jsonValue))
          .toList();
    }

    return Category(
      title: json['title'],
      icon: json['icon'],
      details: _details,
    );
  }
}
