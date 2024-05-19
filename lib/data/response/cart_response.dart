import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_shopping_firestore_real_time/data/response/product_response.dart';

class CartResponse {
  final String cartId;
  final ProductResponse product;
  final String color;

  CartResponse({
    required this.cartId,
    required this.product,
    required this.color,
  });

  factory CartResponse.fromFirestore(
    DocumentSnapshot doc,
    ProductResponse product,
  ) {
    final data = doc.data() as Map<String, dynamic>;
    return CartResponse(
      cartId: doc.id,
      product: product,
      color: data['color'] as String,
    );
  }
}
