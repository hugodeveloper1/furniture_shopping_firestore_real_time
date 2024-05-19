import 'package:flutter/material.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/product_model.dart';

class StaggeredGridView extends StatelessWidget {
  const StaggeredGridView({
    super.key,
    this.products = const [],
    this.spacing = 15,
    this.paddingHorizontal = 0,
    required this.itemBuilder,
    this.childAspectRatio = 0.8,
  });

  final List<ProductModel> products;
  final double spacing;
  final double paddingHorizontal;
  final Widget? Function(ProductModel product) itemBuilder;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      padding: EdgeInsets.symmetric(
        vertical: spacing,
        horizontal: paddingHorizontal,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: paddingHorizontal,
        crossAxisSpacing: paddingHorizontal,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return itemBuilder(products[index]);
      },
    );
  }
}
