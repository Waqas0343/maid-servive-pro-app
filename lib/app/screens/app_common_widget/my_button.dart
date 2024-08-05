import 'package:flutter/material.dart';
import 'package:go_maids_pro/app_assets/app_styles/my_colors.dart';

class MyButton extends StatelessWidget {
  final Color? color;
  final void Function()? onTap;
  final String text;
  final IconData? icon;
  final bool? isLoading;

  const MyButton({
    Key? key,
    this.color = MyColors.greenAccentColor,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      textColor: Colors.white,
      color: color,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Expanded(
                child:isLoading ?? false
                    ? const SizedBox(
                  width: 15.0, // Adjust the width to control the size
                  height: 15.0,
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ): Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
              if(icon != null)...[
                Icon(icon),
              ],
            ],
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }
}
