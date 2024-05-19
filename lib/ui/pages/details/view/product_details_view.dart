// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_shopping_firestore_real_time/domain/models/product_model.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/constants/images_constants.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/theme/app_colors.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/details/provider/details_provider.dart';
import 'package:furniture_shopping_firestore_real_time/ui/pages/home/provider/home_state.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/custom_card.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/custom_image_cache.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/page_layout.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/utils/dialogs_utils.dart';

class ProductDetailsView extends ConsumerStatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends ConsumerState<ProductDetailsView> {
  late DetailsProvider detailsProvider;

  @override
  void initState() {
    super.initState();
    ref.read(detailsStateNotifier.notifier).setProduct(
          product: widget.product,
        );
  }

  @override
  Widget build(BuildContext context) {
    final detailsState = ref.watch(detailsStateNotifier);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    ref.listen(detailsStateNotifier, (previous, next) async {
      switch (next.status) {
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
      body: Stack(
        children: [
          PageLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width,
                  height: size.width * 0.7,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: double.infinity,
                        child: Transform.translate(
                          offset: Offset(size.width * 0.5, 0),
                          child: Hero(
                            tag: detailsState.product?.idProduct ?? '',
                            child: CustomImageCache(
                              url: detailsState.product?.imageUrl ?? '',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: SizedBox(
                          child: Center(
                            child: CustomCard(
                              width: 60,
                              borderRadius: 25,
                              margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                    detailsState.colors.length, (index) {
                                  final color = detailsState.colors[index];
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    height: 30,
                                    width: 30,
                                    padding: const EdgeInsets.all(2),
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color: color.isSelected
                                            ? AppColors.colorDeepTeal
                                            : AppColors.colorGainsboro,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.hexToColor(
                                        color.color,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detailsState.product?.name ?? '',
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${(detailsState.product?.price ?? 0).toStringAsFixed(2)}',
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: AppColors.colorOliveDrab,
                            ),
                          ),
                          Row(
                            children: [
                              CustomCard(
                                width: 35,
                                height: 35,
                                isShadow: false,
                                background: AppColors.colorPlatinum,
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: AppColors.colorCharcoal,
                                ),
                                onTap: () {},
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  '01',
                                  style: textTheme.bodyMedium!.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              CustomCard(
                                width: 35,
                                height: 35,
                                isShadow: false,
                                background: AppColors.colorPlatinum,
                                child: Icon(
                                  Icons.remove,
                                  size: 20,
                                  color: AppColors.colorCharcoal,
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.colorSandyBrown,
                            size: 22,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            (detailsState.product?.starts ?? 0)
                                .toStringAsFixed(1),
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '(500 Reviews)',
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: AppColors.colorTaupeGray,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        detailsState.product?.description ?? '',
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: 10,
              ),
              child: Row(
                children: [
                  CustomCard(
                    width: 50,
                    height: 50,
                    isShadow: false,
                    background: AppColors.colorGainsboro,
                    child: Center(
                      child: Image.asset(
                        ImagesConstants.favorite,
                        color: AppColors.colorCharcoal,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.05),
                  Expanded(
                    child: CustomCard(
                      height: 50,
                      background: AppColors.colorCharcoal,
                      onTap: ref.read(detailsStateNotifier.notifier).addCart,
                      child: Center(
                        child: Text(
                          'Add to cart',
                          style: textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
