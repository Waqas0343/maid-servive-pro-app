import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/debug/debug_pointer.dart';
import '../../../helpers/connectivity.dart';
import '../../../helpers/server/api_fetch.dart';
import '../../services/preferences.dart';
import '../app_common_widget/app_dialog_confirmation.dart';
import '../dialogs/dialog.dart';
import 'notification_model.dart';

class NotificationScreenController extends GetxController{
  final Rxn<NotificationDataModel> userNotificationData = Rxn<NotificationDataModel>();
  final RxList<NotificationDataListModel> userNotificationDataList = RxList<NotificationDataListModel>();
  final DateFormat dateFormat = DateFormat(Keys.dateFormat);
  final DateFormat timeFormat = DateFormat(Keys.timeFormat);
  final RxBool isLoading = true.obs;
  final RxBool buttonAction = RxBool(true);
  int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;
  @override
  void onInit() {
    getUserNotification();
    super.onInit();
  }
  Future<List<NotificationDataListModel>?> getUserNotification() async {
    isLoading.value = true;
    List<NotificationDataListModel>? response = await ApiFetch.getUserNotification(userID);
    isLoading.value = false;
    if (response != null) {
      Debug.log("-------------------------------${response.length}");
      userNotificationDataList.clear();
      userNotificationDataList.addAll(response);
    }
    return response;
  }
  void readNotification(int userId, NotificationDataListModel notification) async {
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }
    Get.dialog(const LoadingSpinner());
    Map<String, dynamic> data = {
      "user_id": userId,
    };

    var response = await ApiFetch.readNotification(data);
    Get.back();
    buttonAction(true);
    if (response != null) {
      // Mark notification as read
      notification.isRead.value = true;
    } else {
      ConfirmationAlert.showDialog(
        title: "Notification Read Failed",
        description: "Failed to mark notification as read.",
        onConfirm: () {

        },
      );
    }
  }

}