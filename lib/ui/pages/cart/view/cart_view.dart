// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/cart/provider/cart_provider.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/cart/widgets/cart_product_card.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/home/provider/home_state.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/page_layout.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/utils/dialogs_utils.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  void initState() {
    super.initState();
    ref.read(cartStateNotifier.notifier).getCartByUserId();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(cartStateNotifier, (previous, next) async {
      switch (next.statusDelete) {
        case StatusPage.loading:
          DialogUtils.customDialog(context);
          break;

        case StatusPage.error:
          break;

        case StatusPage.success:
          Navigator.pop(context);
          break;

        default:
          break;
      }
    });

    return Scaffold(
      body: PageLayout(
        isScroll: false,
        title: 'Cart',
        child: _CartProducts(),
      ),
    );
  }
}

class _CartProducts extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartStateNotifier);
    final size = MediaQuery.of(context).size;

    switch (cartState.status) {
      case StatusPage.loading:
        return SizedBox(
          width: size.width,
          height: size.height * 0.7,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );

      case StatusPage.error:
        return const Center(
          child: Text('Error!'),
        );

      case StatusPage.success:
        return ListView.separated(
          itemCount: cartState.cart.length,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: 15,
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            final cart = cartState.cart[index];
            return CartProductCard(
              cart: cart,
              onTap: () {
                ref.read(cartStateNotifier.notifier).deleteCartItem(
                      cartModel: cart,
                    );
              },
            );
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
