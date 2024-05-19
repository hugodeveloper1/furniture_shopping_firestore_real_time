import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:furniture_shopping_firestore_real_time/data/exception/custom_firebase_exception.dart';
import 'package:furniture_shopping_firestore_real_time/data/request/product_request.dart';
import 'package:furniture_shopping_firestore_real_time/data/response/product_response.dart';

class ProductsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String products = 'PRODUCTS';

  Future<void> addProduct(ProductResquest product) async {
    try {
      await _db.collection(products).add(product.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Stream<Either<CustomFirebaseException, List<ProductResponse>>> getProducts() {
    return _db.collection(products).snapshots().map((snapshot) {
      try {
        final list = snapshot.docs
            .map((doc) => ProductResponse.fromFirestore(doc))
            .toList();
        return Right<CustomFirebaseException, List<ProductResponse>>(list);
      } catch (e) {
        return Left<CustomFirebaseException, List<ProductResponse>>(
          CustomFirebaseException(
            plugin: 'Firestore',
            message: 'Error fetching products: $e',
          ),
        );
      }
    }).handleError((error) {
      return Left<CustomFirebaseException, List<ProductResponse>>(
        CustomFirebaseException(
          plugin: 'Firestore',
          message: 'Error fetching products: $error',
        ),
      );
    }).cast<Either<CustomFirebaseException, List<ProductResponse>>>();
  }
}
