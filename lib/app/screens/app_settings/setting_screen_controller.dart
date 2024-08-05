import 'package:get/get.dart';

import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../services/preferences.dart';

class SettingsController extends GetxController{
  String userName = Get.find<Preferences>().getString(Keys.userName) ?? "";
  String email = Get.find<Preferences>().getString(Keys.email) ?? "";
  @override
  void onInit() {
    super.onInit();
  }
}