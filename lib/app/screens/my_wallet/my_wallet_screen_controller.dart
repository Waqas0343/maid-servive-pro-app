import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/debug/debug_pointer.dart';
import '../../../helpers/server/api_fetch.dart';
import '../my_Orders/models/user_Order_model.dart';

class MyWalletScreenController extends GetxController{
  final RxList<UserOrderListModel> userOrderList = RxList<UserOrderListModel>();
  final RxList<ServiceProviderModel> servicesProviderList = RxList<ServiceProviderModel>();
  final RxList<ServiceTakerModel> servicesTakerList = RxList<ServiceTakerModel>();
  final RxBool isLoading = true.obs;
  final RxBool buttonAction = RxBool(true);
  final DateFormat dateFormat = DateFormat(Keys.dateFormat);
  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    isLoading.value = true;
    List<UserOrderListModel>? response = await ApiFetch.getUserOrderData();
    isLoading.value = false;
    if (response != null) {
      Debug.log("-------------------------------${response}");
      userOrderList.assignAll(response);
      servicesProviderList.assignAll(response.map((order) => order.serviceProvider));
      servicesTakerList.assignAll(response.map((order) => order.serviceTaker));
    }
  }
}