import 'package:get/get.dart';
import 'package:go_maids_pro/helpers/toaster.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../helpers/connectivity.dart';
import '../../../../helpers/server/api_fetch.dart';
import '../../../services/preferences.dart';
import '../models/set_user_availbility_model.dart';

class UserAvailabilityController extends GetxController {
  final RxList<UserAvailabilityListModel> userAvailabilityList = RxList<UserAvailabilityListModel>();
  int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;
  final RxBool isLoading = true.obs;
  final isAddingTimeSlot = false.obs;
  final RxBool buttonAction = RxBool(true);
  int selectedDayIndex = -1;

  final RxList<String> timeSlots = [
    '12:00 AM', '1:00 AM', '2:00 AM', '3:00 AM', '4:00 AM', '5:00 AM', '6:00 AM', '7:00 AM',
    '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '1:00 PM', '2:00 PM', '3:00 PM',
    '4:00 PM', '5:00 PM', '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM'
  ].obs;
  final List<List<String>> selectedStartTimes = List.generate(7, (_) => []);
  final List<List<String>> selectedEndTimes = List.generate(7, (_) => []);

  @override
  void onInit() {
    getWeekDaysList();
    super.onInit();
  }
  Future<void> getWeekDaysList() async {
    isLoading.value = true;
    try {
      UserAvailabilityListModel? response = await ApiFetch.getUserAvailabilityTimeSlot(userID);
      if (response != null) {

        selectedStartTimes.clear();
        selectedEndTimes.clear();
        selectedStartTimes.addAll([
          response.monday.map((day) => formatTime(day.slotStartTime)).toList(),
          response.tuesday.map((day) => formatTime(day.slotStartTime)).toList(),
          response.wednesday.map((day) => formatTime(day.slotStartTime)).toList(),
          response.thursday.map((day) => formatTime(day.slotStartTime)).toList(),
          response.friday.map((day) => formatTime(day.slotStartTime)).toList(),
          response.saturday.map((day) => formatTime(day.slotStartTime)).toList(),
          response.sunday.map((day) => formatTime(day.slotStartTime)).toList(),
        ]);

        selectedEndTimes.addAll([
          response.monday.map((day) => formatTime(day.slotEndTime)).toList(),
          response.tuesday.map((day) => formatTime(day.slotEndTime)).toList(),
          response.wednesday.map((day) => formatTime(day.slotEndTime)).toList(),
          response.thursday.map((day) => formatTime(day.slotEndTime)).toList(),
          response.friday.map((day) => formatTime(day.slotEndTime)).toList(),
          response.saturday.map((day) => formatTime(day.slotEndTime)).toList(),
          response.sunday.map((day) => formatTime(day.slotEndTime)).toList(),
        ]);
        userAvailabilityList.assignAll([response]);
      }
    } catch (e) {
      print("Error fetching week days: $e");
    } finally {
      isLoading.value = false;
    }
  }
  String formatTime(String time24) {
    final hourMinute = time24.split(':');
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);

    String period = 'AM';
    if (hour >= 12) {
      period = 'PM';
      hour = (hour == 12) ? hour : hour - 12;
    }
    if (hour == 0) {
      hour = 12;
    }

    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }
  Future<void> deleteWeekDaySlot(int dayId) async {
    isLoading(true);
    String data = "/${dayId}/user/${userID}";
    bool response = await ApiFetch.deleteWeekDaySlotForUser(data);
    isLoading(false);
    if (response) {
      userAvailabilityList.clear();
      getWeekDaysList();
    } else {
      Toaster.showToast("Time Slot Not Delete");
    }
  }

  void saveNewUserAvailabilitySlot({
    required int id,
    required int slotId,
    required String dayName,
    required String slotStartTime,
    required String slotEndTime,
  }) async {
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }

    List<Map<String, dynamic>> workingSlots = [
      {
        "id": id,
        "slot_id": slotId,
        "name": dayName,
        "slot_start_time": slotStartTime,
        "slot_end_time": slotEndTime
      }
    ];
    Map<String, dynamic> data = {
      "user_id": userID,
      "workingSlots": workingSlots,
    };

    var response = await ApiFetch.addNewUserAvailabilityDaySlot(data);
    buttonAction(true);
    if (response != null) {
      userAvailabilityList.clear();
      getWeekDaysList();
    }
  }

  void saveNewUserAvailabilitySlotWithRandomId({
    required String id,
    required String slotId,
    required String dayName,
    required String slotStartTime,
    required String slotEndTime,
  }) async {
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }

    List<Map<String, dynamic>> workingSlots = [
      {
        "id": id,
        "slot_id": slotId,
        "name": dayName,
        "slot_start_time": slotStartTime,
        "slot_end_time": slotEndTime
      }
    ];
    Map<String, dynamic> data = {
      "user_id": userID,
      "workingSlots": workingSlots,
    };

    var response = await ApiFetch.addNewUserAvailabilityDaySlot(data);
    buttonAction(true);
    if (response != null) {
      userAvailabilityList.clear();
      getWeekDaysList();
    }
  }


  void setSelectedStartTime(int dayIndex, int i, String value) {
    selectedStartTimes[dayIndex][i] = value;
    update();
  }

  void setSelectedEndTime(int dayIndex, int i, String value) {
    selectedEndTimes[dayIndex][i] = value;
    update();
  }

  void addTimeSlot(int dayIndex) {
    if (dayIndex == selectedDayIndex) {
      if (!isAddingTimeSlot.value) {
        isAddingTimeSlot.value = true;
        if (dayIndex >= 0 && dayIndex < selectedStartTimes.length) {
          if (!isDuplicateTimeSlot(dayIndex, '12:00AM')) {
            selectedStartTimes[dayIndex].add('12:00AM');
            selectedEndTimes[dayIndex].add('12:00AM');
            update();
          }
        }
        Future.delayed(Duration(milliseconds: 500), () {
          isAddingTimeSlot.value = false;
        });
      }
    }
  }

  bool isDuplicateTimeSlot(int dayIndex, String timeSlot) {
    for (int i = 0; i < selectedStartTimes[dayIndex].length; i++) {
      if (selectedStartTimes[dayIndex][i] == timeSlot ||
          selectedEndTimes[dayIndex][i] == timeSlot) {
        return true;
      }
    }
    return false;
  }
}
