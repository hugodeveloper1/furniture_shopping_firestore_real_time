import 'package:furniture_shopping_firestore_real_time/data/response/product_color_response.dart';

class ProductColorModel {
  final String color;
  final bool isSelected;

  ProductColorModel({
    required this.color,
    required this.isSelected,
  });

  factory ProductColorModel.fromMap(ProductColorResponse response) {
    return ProductColorModel(
      color: response.color,
      isSelected: response.isSelected,
    );
  }

  ProductColorModel copyWith({
    String? color,
    bool? isSelected,
  }) {
    return ProductColorModel(
      color: color ?? this.color,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
