// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/product_model.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/constants/images_constants.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/theme/app_colors.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/cart/view/cart_view.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/home/provider/home_provider.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/home/provider/home_state.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/home/widgets/home_categories.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/home/widgets/home_navigation.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/home/widgets/product_card.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/custom_card.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/staggered_grid_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(homeStateNotifier.notifier).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeState = ref.watch(homeStateNotifier);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final paddingHorizontal = size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FurnitureCo.'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartView(),
                ),
              );
            },
            icon: Center(
              child: Image.asset(
                ImagesConstants.cart,
                color: AppColors.colorEerieBlack,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 7,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal,
                vertical: 7,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomCard(
                      isShadow: false,
                      width: double.infinity,
                      height: 50,
                      background: AppColors.colorGhostWhite,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Search for furniture',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: paddingHorizontal),
                  CustomCard(
                    width: 50,
                    height: 50,
                    background: AppColors.colorDarkGray,
                    isShadow: false,
                    child: Center(
                      child: Image.asset(
                        ImagesConstants.filter,
                        color: AppColors.colorWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 7),
              child: HomeCategories(),
            ),
            Expanded(
              child: _ProductsList(
                status: homeState.status,
                padding: paddingHorizontal,
                products: homeState.products,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeNavigation(),
    );
  }
}

class _ProductsList extends StatelessWidget {
  const _ProductsList({
    required this.status,
    this.padding = 0,
    this.products = const [],
  });

  final StatusPage status;
  final List<ProductModel> products;
  final double padding;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StatusPage.loading:
        return Container();

      case StatusPage.error:
        return Container();

      case StatusPage.success:
        return StaggeredGridView(
          products: products,
          spacing: 15,
          paddingHorizontal: padding,
          itemBuilder: (product) {
            return ProductCard(
              product: product,
            );
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
