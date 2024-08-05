import 'package:get/get.dart';
import 'package:go_maids_pro/helpers/server/api_fetch.dart';

import '../../../../app_assets/debug/debug_pointer.dart';
import '../models/user_chats_model.dart';

class MessageScreenController extends GetxController{
  final RxList<ChatDataModel> chatDataList = RxList<ChatDataModel>();
  final RxBool isLoading = true.obs;
  @override
  void onInit() {
    getChatsListData();
    super.onInit();
  }

  Future<void> getChatsListData() async {
    try {
      isLoading.value = true;
      List<ChatDataModel>? response = await ApiFetch.getUserChatModelData(); // Adjust to your API function
      isLoading.value = false;
      if (response != null) {
        chatDataList.assignAll(response);
        Debug.log("Chats fetched successfully: $chatDataList");
      }
    } catch (error) {
      isLoading.value = false;
      Debug.log('Error fetching chats: $error');
    }
  }


}