import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:furniture_shopping_firestore_real_time/data/exception/custom_firebase_exception.dart';
import 'package:furniture_shopping_firestore_real_time/data/remote/cart_remote.dart';
import 'package:furniture_shopping_firestore_real_time/data/request/cart_request.dart';
import 'package:furniture_shopping_firestore_real_time/data/services/products_services.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/cart_model.dart';

class CartRepository {
  final _remote = CartRemote();
  final String userId = 'iduser';
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Either<CustomFirebaseException, bool>> addProductToCart({
    required String productId,
    required String color,
  }) async {
    final productRef = _db.collection(ProductsService.products).doc(productId);
    final request = CartRequest(productRef: productRef, color: color);
    final response = await _remote.addProductToCart(
      request: request,
      userId: userId,
    );
    return response.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  Future<Either<CustomFirebaseException, List<CartModel>>>
      getCartByUserId() async {
    final response = await _remote.getCartProducts(userId: userId);
    return response.fold(
      (l) => Left(l),
      (r) {
        final cartList = r.map((e) => CartModel.fromMap(e)).toList();
        return Right(cartList);
      },
    );
  }

  Future<Either<CustomFirebaseException, bool>> deleteCartItem({
    required String cartItemId,
  }) async {
    final response = await _remote.deleteCartItem(
      userId: userId,
      cartItemId: cartItemId,
    );
    return response.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
