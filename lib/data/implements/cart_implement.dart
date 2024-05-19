import 'package:dartz/dartz.dart';
import 'package:furniture_shopping_firestore_real_time/data/exception/custom_firebase_exception.dart';
import 'package:furniture_shopping_firestore_real_time/data/request/cart_request.dart';
import 'package:furniture_shopping_firestore_real_time/data/response/cart_response.dart';

abstract class CartImplement {
  Future<Either<CustomFirebaseException, bool>> addProductToCart({
    required String userId,
    required CartRequest request,
  });

  Future<Either<CustomFirebaseException, List<CartResponse>>> getCartProducts({
    required String userId,
  });

  Future<Either<CustomFirebaseException, bool>> deleteCartItem({
    required String userId,
    required String cartItemId,
  });
}
