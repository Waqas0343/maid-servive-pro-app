import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarSearchWidget extends StatelessWidget {
  const AppBarSearchWidget({
    Key? key,
    this.onTap,
    this.hintText = "Search",
    required this.heroId,
  }) : super(key: key);
  final VoidCallback? onTap;
  final String hintText;
  final String heroId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: Hero(
          tag: heroId,
          child: Material(
            color: Colors.transparent,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                fillColor: Colors.white,
                filled: true,
                isCollapsed: true,
                hintText: hintText,
                hintStyle: Get.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}