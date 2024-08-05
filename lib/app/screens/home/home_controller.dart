import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:go_maids_pro/app/routes/app_routes.dart';
import 'package:go_maids_pro/helpers/server/api_fetch.dart';
import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/debug/debug_pointer.dart';
import '../../services/preferences.dart';
import 'model/user_status_model_for_home.dart';

class HomeController extends GetxController {
  final Rx<UserStatusModel?> userStatus = Rx<UserStatusModel?>(null);
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
  String userName = Get.find<Preferences>().getString(Keys.userName) ?? "";
  int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;
  final RxBool isLoading = true.obs;
  RxInt selectedIndex = 0.obs;
  List<dynamic> videos = [
    'NGPeaE6mtuU',
    'VfcrvrUwB6w',
    'BQ36Jjq31U8',
    'sNhfS-IxZ7o',
    '3MTAK2tqOzA',
    'ZjPhb8Nbv2A',
  ];
  @override
  void onInit() {
    Debug.log("Token $token");
    Debug.log("Cmp $userName");
    getUserStatus();
    super.onInit();
  }

  Future<void> getUserStatus() async {

    try {
      final status = await ApiFetch.getUserPaymentForHomeStatus(userID);
      if (status != null) {
        userStatus.value = status;
      } else {
        Debug.log('Failed to fetch user status');
      }
    } catch (e) {
      Debug.log('Error fetching user status: $e');
    }
  }
  String get greeting {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
  void onItemTapped(int index) {
    // Handle bottom navigation item tap
    selectedIndex.value = index;
    // Perform actions based on the selected index, e.g., navigate to a different page
    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.home);
        break;
      case 1:
        Get.toNamed(AppRoutes.myAccount);
        break;
      case 2:
        Get.toNamed(AppRoutes.notificationScreen);
        break;
      case 3:
        Get.toNamed(AppRoutes.messagesScreen);
        break;
      case 4:
        Get.toNamed(AppRoutes.settingsScreen);
        break;
    }
  }
}
