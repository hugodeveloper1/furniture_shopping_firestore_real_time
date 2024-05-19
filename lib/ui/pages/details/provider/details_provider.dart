import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/product_color_model.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/product_model.dart';
import 'package:furniture_shopping_firestore_real_time/domain/repositories/cart_repository.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/home/provider/home_state.dart';

import 'details_state.dart';

AutoDisposeStateNotifierProvider<DetailsProvider, DetailsState>
    detailsStateNotifier =
    AutoDisposeStateNotifierProvider<DetailsProvider, DetailsState>(
  (ref) {
    return DetailsProvider(ref);
  },
);

class DetailsProvider extends StateNotifier<DetailsState> {
  DetailsProvider(this.ref) : super(const DetailsState());

  final StateNotifierProviderRef ref;

  void setProduct({
    required ProductModel product,
  }) async {
    List<ProductColorModel> colors = [...product.colors];

    if (colors.isNotEmpty) {
      colors[0] = colors[0].copyWith(
        isSelected: true,
      );
    }
    state = state.copyWith(
      product: product,
      colors: colors,
    );
  }

  void addCart() async {
    state = state.copyWith(
      status: StatusPage.loading,
    );

    final response = await ref.read(cartRepositoryProvider).addProductToCart(
          productId: state.product?.idProduct ?? '',
          color: state.product?.colors[0].color ?? '',
        );

    response.fold(
      (l) {
        state = state.copyWith(
          status: StatusPage.error,
        );
      },
      (r) {
        state = state.copyWith(
          status: StatusPage.success,
        );
      },
    );
  }
}

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});
