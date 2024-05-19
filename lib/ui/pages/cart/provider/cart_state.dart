import 'package:equatable/equatable.dart';

import 'package:furniture_shopping_firestore_real_time/domain/models/cart_model.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/home/provider/home_state.dart';

class CartState extends Equatable {
  const CartState({
    this.cart = const [],
    this.status = StatusPage.loading,
    this.statusDelete = StatusPage.initial,
  });

  final List<CartModel> cart;
  final StatusPage status;
  final StatusPage statusDelete;

  @override
  List<Object?> get props => [
        cart,
        status,
        statusDelete,
      ];

  CartState copyWith({
    List<CartModel>? cart,
    StatusPage? status,
    StatusPage? statusDelete,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      status: status ?? this.status,
      statusDelete: statusDelete ?? this.statusDelete,
    );
  }
}
