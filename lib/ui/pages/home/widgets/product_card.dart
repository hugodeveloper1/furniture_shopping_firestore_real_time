import 'package:flutter/material.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/product_model.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/theme/app_colors.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/details/view/product_details_view.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/custom_card.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/custom_image_cache.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        /* ProductsService().deleteProduct(
          productId: product.idProduct,
        ); */
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetailsView(
              product: product,
            );
          },
        ));
      },
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: (size.width / 2) / 3.1,
              ),
              Expanded(
                child: CustomCard(
                  child: Container(),
                ),
              ),
            ],
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Hero(
                    tag: product.idProduct,
                    child: CustomImageCache(
                      url: product.imageUrl,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              color: AppColors.colorOliveDrab,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ],
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
