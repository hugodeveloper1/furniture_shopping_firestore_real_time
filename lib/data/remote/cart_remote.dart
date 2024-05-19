import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:furniture_shopping_firestore_real_time/data/exception/custom_firebase_exception.dart';
import 'package:furniture_shopping_firestore_real_time/data/implements/cart_implement.dart';
import 'package:furniture_shopping_firestore_real_time/data/request/cart_request.dart';
import 'package:furniture_shopping_firestore_real_time/data/response/cart_response.dart';
import 'package:furniture_shopping_firestore_real_time/data/response/product_response.dart';

class CartRemote extends CartImplement {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _cart = 'CARTS';
  final String _user = 'USERS';

  @override
  Future<Either<CustomFirebaseException, bool>> addProductToCart({
    required String userId,
    required CartRequest request,
  }) async {
    try {
      await _db
          .collection(_user)
          .doc(userId)
          .collection(_cart)
          .add(request.toMap());
      return const Right(true);
    } catch (e) {
      return Left(CustomFirebaseException(
        plugin: 'Firestore',
        message: 'Error adding product to cart: $e',
      ));
    }
  }

  @override
  Future<Either<CustomFirebaseException, List<CartResponse>>> getCartProducts({
    required String userId,
  }) async {
    try {
      final cartSnapshot =
          await _db.collection(_user).doc(userId).collection(_cart).get();
      final productRefs = cartSnapshot.docs
          .map((doc) => doc['productRef'] as DocumentReference)
          .toList();

      final productSnapshots =
          await Future.wait(productRefs.map((ref) => ref.get()));
      final products = productSnapshots
          .map((doc) => ProductResponse.fromFirestore(doc))
          .toList();

      final cartResponses = cartSnapshot.docs.asMap().entries.map((entry) {
        final product = products[entry.key];
        return CartResponse.fromFirestore(entry.value, product);
      }).toList();

      return Right(cartResponses);
    } catch (e) {
      return Left(CustomFirebaseException(
        plugin: 'Firestore',
        message: 'Error fetching cart products: $e',
      ));
    }
  }

  @override
  Future<Either<CustomFirebaseException, bool>> deleteCartItem({
    required String userId,
    required String cartItemId,
  }) async {
    try {
      await _db
          .collection(_user)
          .doc(userId)
          .collection(_cart)
          .doc(cartItemId)
          .delete();
      return const Right(true);
    } catch (e) {
      return Left(CustomFirebaseException(
        plugin: 'Firestore',
        message: 'Error deleting cart item: $e',
      ));
    }
  }
}
