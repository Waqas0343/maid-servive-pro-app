import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_assets/app_styles/my_colors.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final EdgeInsets? padding;

  const TitleWidget({
    Key? key,
    required this.title,
    this.onTap,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: Get.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 16.0,
            ),
          ),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: Text(
                "View All",
                style: Get.theme.textTheme.titleSmall!.copyWith(
                  color: MyColors.blueColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}