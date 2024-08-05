import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../app_assets/app_styles/text_styles/text_styles.dart';
import '../../../app_assets/spacing.dart';

class ToolsWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;

  const ToolsWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: MyTextStyle.height100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF307cec).withOpacity(0.4)
              ),
              child: SvgPicture.asset(
                icon,
                height: 28,
                width: 28,
              ),
            ),
            widgetSpacerVertically(),
            Text(
              title,
              style: Get.theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black87
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}