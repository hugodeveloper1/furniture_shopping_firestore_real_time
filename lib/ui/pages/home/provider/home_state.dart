import 'package:equatable/equatable.dart';

import 'package:furniture_shopping_firestore_real_time/domain/models/product_model.dart';

enum StatusPage { initial, loading, error, success }

class HomeState extends Equatable {
  const HomeState({
    this.products = const [],
    this.status = StatusPage.loading,
  });

  final List<ProductModel> products;
  final StatusPage status;

  @override
  List<Object?> get props => [
        products,
        status,
      ];

  HomeState copyWith({
    List<ProductModel>? products,
    StatusPage? status,
  }) {
    return HomeState(
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }
}
