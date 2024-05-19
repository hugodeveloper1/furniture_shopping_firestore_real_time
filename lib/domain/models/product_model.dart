import 'package:furniture_shopping_firestore_real_time/data/response/product_response.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/product_color_model.dart';

class ProductModel {
  final String idProduct;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double starts;
  final List<ProductColorModel> colors;

  ProductModel({
    required this.idProduct,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.starts,
    required this.colors,
  });

  factory ProductModel.fromMap(ProductResponse response) {
    return ProductModel(
      idProduct: response.idProduct,
      name: response.name,
      description: response.description,
      imageUrl: response.imageUrl,
      price: double.parse(response.price),
      starts: double.parse(response.starts),
      colors: response.colors.map((e) => ProductColorModel.fromMap(e)).toList(),
    );
  }
}
