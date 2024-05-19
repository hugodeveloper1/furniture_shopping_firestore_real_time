import 'package:cloud_firestore/cloud_firestore.dart';

class CartRequest {
  final DocumentReference<Map<String, dynamic>> productRef;
  final String color;

  CartRequest({
    required this.productRef,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'productRef': productRef});
    result.addAll({'color': color});

    return result;
  }
}
