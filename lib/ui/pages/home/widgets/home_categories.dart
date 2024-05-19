import 'package:flutter/material.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/constants/images_constants.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/theme/app_colors.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/custom_card.dart';

enum CategoryType {
  popular,
  chairs,
  tables,
  sofas,
  beds;

  String get name {
    switch (this) {
      case popular:
        return 'Popular';

      case chairs:
        return 'Chairs';

      case tables:
        return 'Tables';

      case sofas:
        return 'Sofas';

      case beds:
        return 'Beds';
    }
  }

  String get icon {
    switch (this) {
      case popular:
        return ImagesConstants.star;

      case chairs:
        return ImagesConstants.chairs;

      case tables:
        return ImagesConstants.table;

      case sofas:
        return ImagesConstants.sofa;

      case beds:
        return ImagesConstants.bed;
    }
  }
}

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 50,
      child: ListView.separated(
        itemCount: CategoryType.values.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        separatorBuilder: (context, index) {
          return SizedBox(width: size.width * 0.05);
        },
        itemBuilder: (context, index) {
          final category = CategoryType.values[index];
          return CustomCard(
            width: 50,
            height: 50,
            isShadow: false,
            background: index == 0
                ? AppColors.colorDarkGray
                : AppColors.colorWhiteSmoke,
            child: Center(
              child: Image.asset(
                category.icon,
              ),
            ),
          );
        },
      ),
    );
  }
}
