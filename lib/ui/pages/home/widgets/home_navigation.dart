import 'package:flutter/material.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/constants/images_constants.dart';
import 'package:furniture_shopping_firestore_real_time/ui/widgets/custom_card.dart';

enum HomeSection {
  home,
  favorite,
  notification,
  user;

  String get icon {
    switch (this) {
      case home:
        return ImagesConstants.home;

      case favorite:
        return ImagesConstants.favorite;

      case notification:
        return ImagesConstants.notification;

      case user:
        return ImagesConstants.user;
    }
  }
}

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomCard(
      width: size.width,
      height: kBottomNavigationBarHeight,
      borderRadius: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: HomeSection.values.map((e) {
          return _icon(e.icon);
        }).toList(),
      ),
    );
  }

  Widget _icon(String icon) {
    return Center(
      child: Image.asset(
        icon,
      ),
    );
  }
}
