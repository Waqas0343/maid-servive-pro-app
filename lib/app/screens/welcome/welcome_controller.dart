import 'package:get/get.dart';
import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../services/preferences.dart';

class WelcomeController extends GetxController {
  var onBoard = false.obs;

  @override
  void onInit() {
    checkNavigate();
    super.onInit();
  }

  void checkNavigate() async {
    Get.find<Preferences>().setString(Keys.userId, "UserId");
    // onBoard.value = prefs.getBool("showhome") ?? false;
  }
}
