import 'package:flutter/material.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/cart_model.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/product_model.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/theme/app_colors.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/custom_card.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/custom_image_cache.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({
    super.key,
    required this.cart,
    required this.onTap,
  });

  final CartModel cart;
  final VoidCallback onTap;
  ProductModel get product => cart.product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    double itemHeight = 120;
    double sizeWidthImage = 100;

    return SizedBox(
      width: size.width,
      height: itemHeight,
      child: Stack(
        children: [
          CustomCard(
            width: size.width,
            height: itemHeight,
            margin: EdgeInsets.only(left: sizeWidthImage * 0.4),
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              children: [
                SizedBox(
                  width: sizeWidthImage,
                  child: CustomImageCache(
                    url: cart.product.imageUrl,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: AppColors.colorOliveDrab,
                          ),
                        ),
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.hexToColor(cart.color),
                            ),
                            IconButton(
                              onPressed: onTap,
                              icon: Icon(
                                Icons.delete,
                                color: AppColors.colorCharcoal,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
