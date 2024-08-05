import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../../app_assets/app_styles/my_images.dart';
import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../routes/app_routes.dart';
import '../../services/preferences.dart';

class IntroController extends GetxController {
  final List<PageViewModel> _pages = [
    PageViewModel(
      titleWidget: Column(
        children: [
          Text(
            'Looking for More Work?',
            style: GoogleFonts.aladin(
              fontSize: 25,
              color: Color.fromARGB(
                255,
                13,
                71,
                119,
              ),
            ),
          ),
        ],
      ),
      bodyWidget: Column(
        children: [
          Text(
            'Create Your Profile and Watch the Orders Pour In!',
            style: GoogleFonts.beVietnamPro(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      image: Center(
        child: Image.asset(
          MyImages.introPic1,
          width: Get.width * 0.6, // Adjust width as needed
        ),
      ),
      decoration: const PageDecoration(
        imagePadding: EdgeInsets.all(24),
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: [
          Text(
            'Work on Your Own Terms!',
            style: GoogleFonts.aladin(
              fontSize: 25,
              color: Color.fromARGB(
                255,
                13,
                71,
                119,
              ),
            ),
          ),
        ],
      ),
      bodyWidget: Column(
        children: [
          Text(
            'Set Your Own Schedule and Pay Rate',
            style: GoogleFonts.beVietnamPro(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      image: Center(
        child: Image.asset(
          MyImages.introPic2,
          width: Get.width * 0.6, // Adjust width as needed
        ),
      ),
      decoration: const PageDecoration(
        imagePadding: EdgeInsets.all(24),
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: [
          Text(
            'Make it Worth Your While!',
            style: GoogleFonts.aladin(
              fontSize: 25,
              color: Color.fromARGB(
                255,
                13,
                71,
                119,
              ),
            ),
          ),
        ],
      ),
      bodyWidget: Column(
        children: [
          Text(
            'Earn More Money For Your Time',
            style: GoogleFonts.beVietnamPro(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      image: Center(
        child: Image.asset(
          MyImages.introPic3,
          width: Get.width * 0.6, // Adjust width as needed
        ),
      ),
      decoration: const PageDecoration(
        imagePadding: EdgeInsets.all(24),
      ),
    ),
  ];

  List<PageViewModel> get pages => _pages;

  void moveToHome() async {
    Get.find<Preferences>().setBool(Keys.isFirstTime, false);
    bool status = Get.find<Preferences>().getBool(Keys.status) ?? false;
    if (status) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.welcome_screen);
    }
  }
}
