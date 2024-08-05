import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../app_assets/app_styles/my_colors.dart';
import 'introduction_controller.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IntroController controller = Get.put(IntroController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: IntroductionScreen(
              pages: controller.pages,
              onDone: () => controller.moveToHome(),
              done: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 12, 56, 92),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () => controller.moveToHome(),
                child: Row(
                  children: [
                    Text(
                      "Get Started",
                      style: Get.theme.textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ],
                ),
              ),
              dotsDecorator: const DotsDecorator(
                activeColor: MyColors.primaryColor,
                activeSize: Size.fromRadius(6.5),
              ),
              showNextButton: true,
              next: const Icon(
                Icons.arrow_forward,
                color: MyColors.primaryColor,
              ),
              showSkipButton: true,
              skip: Text(
                "Skip",
                style: Get.theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: MyColors.primaryColor,
                ),
              ),
              skipOrBackFlex: 0,
              nextFlex: 0,
              onSkip: () => controller.moveToHome(),
            ),
          ),
        ],
      ),
    );
  }
}
