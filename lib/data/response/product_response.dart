import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_shopping_firestore_real_time/data/response/product_color_response.dart';

class ProductResponse {
  final String idProduct;
  final String name;
  final String description;
  final String imageUrl;
  final String price;
  final String starts;
  final List<ProductColorResponse> colors;

  ProductResponse({
    required this.idProduct,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.starts,
    required this.colors,
  });

  // Método para crear ProductResponse desde Firestore
  factory ProductResponse.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProductResponse(
      idProduct: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['image_url'] ?? '',
      price: (data['price'] ?? 0).toString(),
      starts: (data['starts'] ?? 0).toString(),
      colors: ((data['colors'] ?? []) as List)
          .map((e) => ProductColorResponse.fromFirestore(e))
          .toList(),
    );
  }
}
