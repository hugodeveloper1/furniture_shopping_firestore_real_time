import 'package:flutter/material.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/theme/app_colors.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/custom_card.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.child,
    this.title = '',
    this.isScroll = true,
  });

  final Widget child;
  final String title;
  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    double toolbarHeight = kToolbarHeight * 0.65;
    final size = MediaQuery.of(context).size;

    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        title.isNotEmpty
            ? SliverAppBar(
                leading: Center(
                  child: CustomCard(
                    height: toolbarHeight,
                    width: toolbarHeight,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 20,
                      color: AppColors.colorCharcoal,
                    ),
                  ),
                ),
                backgroundColor: AppColors.colorWhite.withOpacity(0.7),
                forceElevated: true,
                surfaceTintColor: Colors.white,
                pinned: true,
                floating: true,
                elevation: 0,
                forceMaterialTransparency: false,
                expandedHeight: size.width * 0.6,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    final isExpanded =
                        constraints.maxHeight > kToolbarHeight * 1.5;
                    return FlexibleSpaceBar(
                      title: isExpanded
                          ? const SizedBox.shrink()
                          : Text(
                              title,
                              style:
                                  Theme.of(context).appBarTheme.titleTextStyle,
                            ),
                      background: Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top +
                              kToolbarHeight,
                          left: size.width * 0.05,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: size.width * 0.15,
                                  ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : SliverAppBar(
                leading: Center(
                  child: CustomCard(
                    height: toolbarHeight,
                    width: toolbarHeight,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 20,
                      color: AppColors.colorCharcoal,
                    ),
                  ),
                ),
                backgroundColor: AppColors.colorWhite,
                pinned: true,
                floating: true,
                elevation: 0,
                forceMaterialTransparency: true,
              ),
      ],
      body: isScroll
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: child,
            )
          : child,
    );
  }
}
