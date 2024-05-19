import 'package:furniture_shopping_firestore_real_time/data/response/cart_response.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/product_model.dart';

class CartModel {
  final String cartId;
  final ProductModel product;
  final String color;

  CartModel({
    required this.cartId,
    required this.product,
    required this.color,
  });

  factory CartModel.fromMap(CartResponse response) {
    return CartModel(
      cartId: response.cartId,
      product: ProductModel.fromMap(response.product),
      color: response.color,
    );
  }
}
