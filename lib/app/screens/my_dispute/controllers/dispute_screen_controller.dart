import 'package:get/get.dart';

import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../app_assets/debug/debug_pointer.dart';
import '../../../../helpers/server/api_fetch.dart';
import '../../../services/preferences.dart';
import '../models/get_user_dispute_model.dart';

class DisputeScreenController extends GetxController {
  final Rxn<UserDisputeDataModel> userDisputeData = Rxn<UserDisputeDataModel>();
  final RxList<UserDisputeDataListModel> userDisputeList = RxList<UserDisputeDataListModel>();
  final RxList<User> usersForList = RxList<User>();
  final RxList<User> usersList = RxList<User>();
  final RxList<Order> orderList = RxList<Order>();
  final RxBool isLoading = true.obs;
  final RxBool buttonAction = RxBool(true);
  int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;

  @override
  void onInit() {
    getUserDispute();
    super.onInit();
  }

  Future<void> getUserDispute() async {
    isLoading.value = true;
    UserDisputeDataModel? response = await ApiFetch.getUserDispute(userID);
    isLoading.value = false;
      if (response != null) {
      Debug.log("-------------------------------${response}");

      // Clearing existing data from lists
      usersForList.clear();
      usersList.clear();
      userDisputeList.addAll(response.data);
      usersForList.addAll(response.data.map((dispute) => dispute.userFor));
      usersList.addAll(response.data.map((dispute) => dispute.user));
      orderList.addAll(response.data.map((dispute) => dispute.order));
    }
  }

}