import 'package:dartz/dartz.dart';
import 'package:furniture_shopping_firestore_real_time/data/exception/custom_firebase_exception.dart';
import 'package:furniture_shopping_firestore_real_time/data/services/products_services.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/product_model.dart';

class ProductsRemote {
  final _services = ProductsService();

  Stream<Either<CustomFirebaseException, List<ProductModel>>> getProducts() {
    return _services.getProducts().map((value) {
      return value.fold(
        (l) => Left(l),
        (r) {
          final products = r.map((e) => ProductModel.fromMap(e)).toList();
          return Right(products);
        },
      );
    });
  }
}
