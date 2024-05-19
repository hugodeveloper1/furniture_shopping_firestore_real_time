import 'package:equatable/equatable.dart';

import 'package:furniture_shopping_firestore_real_time/domain/models/product_color_model.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/product_model.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/home/provider/home_state.dart';

class DetailsState extends Equatable {
  const DetailsState({
    this.product,
    this.colors = const [],
    this.status = StatusPage.loading,
  });

  final List<ProductColorModel> colors;
  final ProductModel? product;
  final StatusPage status;

  @override
  List<Object?> get props => [
        product,
        colors,
        status,
      ];

  DetailsState copyWith({
    List<ProductColorModel>? colors,
    ProductModel? product,
    StatusPage? status,
  }) {
    return DetailsState(
      colors: colors ?? this.colors,
      product: product ?? this.product,
      status: status ?? this.status,
    );
  }
}
