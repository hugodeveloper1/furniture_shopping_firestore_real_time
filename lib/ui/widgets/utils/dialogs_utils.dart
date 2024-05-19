// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/theme/app_colors.dart';

class DialogUtils {
  static Future<void> customDialog(
    BuildContext context,
  ) async {
    final size = MediaQuery.of(context).size;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            surfaceTintColor: AppColors.colorWhite,
            backgroundColor: AppColors.colorWhite,
            elevation: 6,
            shadowColor: Colors.black12,
            child: SizedBox(
              height: size.width * 0.5,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
