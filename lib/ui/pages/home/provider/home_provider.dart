import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_shopping_firestore_real_time/domain/repositories/products_repository.dart';

import 'home_state.dart';

AutoDisposeStateNotifierProvider<HomeProvider, HomeState> homeStateNotifier =
    AutoDisposeStateNotifierProvider<HomeProvider, HomeState>(
  (ref) {
    return HomeProvider(ref);
  },
);

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider(this.ref) : super(const HomeState());

  final StateNotifierProviderRef ref;

  void getProducts() async {
    final response = ref.read(productsRepositoryProvider).getProducts();
    response.listen((response) {
      response.fold(
        (l) {
          state = state.copyWith(
            status: StatusPage.error,
            products: [],
          );
        },
        (r) {
          state = state.copyWith(
            status: StatusPage.success,
            products: r,
          );
        },
      );
    });
  }
}

final productsRepositoryProvider = Provider<ProductsRemote>((ref) {
  return ProductsRemote();
});
