import 'package:get/get.dart';

import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../helpers/connectivity.dart';
import '../../../../helpers/server/api_fetch.dart';
import '../../../../helpers/toaster.dart';
import '../../../routes/app_routes.dart';
import '../../../services/preferences.dart';
import '../../dialogs/dialog.dart';

class LoginUserSetAvailabilityController extends GetxController {
  int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;
  static List<String> hours = [
    '12:00AM', '1:00AM', '2:00AM', '3:00AM', '4:00AM', '5:00AM', '6:00AM', '7:00AM', '8:00AM', '9:00AM', '10:00AM', '11:00AM',
    '12:00PM', '1:00PM', '2:00PM', '3:00PM', '4:00PM', '5:00PM', '6:00PM', '7:00PM', '8:00PM', '9:00PM', '10:00PM', '11:00PM',
  ];

  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  Map<String, int> dayIds = {
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6,
    'Sunday': 7,
  };

  Map<int, bool> availabilityMap = {};
  final RxBool buttonAction = RxBool(true);
  String? selectedStartTime;
  String? selectedEndTime;

  @override
  void onInit() {
    days.forEach((day) {
      availabilityMap[dayIds[day]!] = false;
    });
    super.onInit();
  }

  void toggleDaySelection(String day, bool isChecked) {
    availabilityMap[dayIds[day]!] = isChecked;
    update();
  }

  void selectStartTime(String startTime) {
    selectedStartTime = startTime;
    update();
  }

  void selectEndTime(String endTime) {
    selectedEndTime = endTime;
    update();
  }

  void saveUserAvailability() async {
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }
    Get.dialog(const LoadingSpinner());
    Map<String, dynamic> data = {
      "slot_start_time": selectedStartTime,
      "slot_end_time": selectedEndTime
    };

    var response = await ApiFetch.saveUserAvailabilityTime(data);
    Get.back();
    buttonAction(true);
    if (response != null) {
      final userData = response['message'];
      final slotId = response['data']['id'];
      Get.find<Preferences>().setBool(Keys.status, true);
      Toaster.showToast(userData);
      print('Slot ID: $slotId');
      saveUserDaysAvailability(slotId);
    }
  }


  void saveUserDaysAvailability(int slotId) async {
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }
    Get.dialog(const LoadingSpinner());
    List<Map<String, dynamic>> chosenDay = [];
    for (var day in days) {
      var isChecked = availabilityMap[dayIds[day]];
      if (isChecked != null) {  // Check if isChecked is not null
        chosenDay.add({
          "id": dayIds[day],
          "status": isChecked ? "1" : "0",
        });
      }
    }
    Map<String, dynamic> data = {
      "chosenDay": chosenDay,
      "user_id": userID,
      "slot_id": slotId,
    };

    var response = await ApiFetch.saveUserAvailabilityDaySlot(data);
    Get.back();
    buttonAction(true);
    if (response != null) {
      // final userData = response['message'];
      final userId = response['data']['id'];
      Get.find<Preferences>().setBool(Keys.status, true);
      // Toaster.showToast(userData);
      print('User ID: $userId');
      Get.offAllNamed(AppRoutes.home);
    }
  }





}
