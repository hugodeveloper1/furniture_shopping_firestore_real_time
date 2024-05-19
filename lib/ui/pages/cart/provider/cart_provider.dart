import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/cart_model.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/details/provider/details_provider.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/home/provider/home_state.dart';

import 'cart_state.dart';

AutoDisposeStateNotifierProvider<CartProvider, CartState> cartStateNotifier =
    AutoDisposeStateNotifierProvider<CartProvider, CartState>(
  (ref) {
    return CartProvider(ref);
  },
);

class CartProvider extends StateNotifier<CartState> {
  CartProvider(this.ref) : super(const CartState());

  final StateNotifierProviderRef ref;

  void getCartByUserId() async {
    final response = await ref.read(cartRepositoryProvider).getCartByUserId();

    response.fold(
      (l) {
        state = state.copyWith(
          status: StatusPage.error,
        );
      },
      (r) {
        state = state.copyWith(
          status: StatusPage.success,
          cart: r,
        );
      },
    );
  }

  void deleteCartItem({
    required CartModel cartModel,
  }) async {
    state = state.copyWith(
      statusDelete: StatusPage.loading,
    );

    final response = await ref.read(cartRepositoryProvider).deleteCartItem(
          cartItemId: cartModel.cartId,
        );

    response.fold(
      (l) {
        state = state.copyWith(
          statusDelete: StatusPage.error,
        );
      },
      (r) {
        final cart = [...state.cart];
        cart.remove(cartModel);
        state = state.copyWith(
          cart: cart,
          statusDelete: StatusPage.success,
        );
      },
    );
  }
}
