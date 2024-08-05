import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_assets/debug/debug_pointer.dart';
import '../../../helpers/connectivity.dart';
import '../../../helpers/server/api_fetch.dart';
import '../../routes/app_routes.dart';
import '../app_common_widget/my_button.dart';
import '../dialogs/dialog.dart';
import 'models/user_Order_model.dart';

class MyOrderScreenController extends GetxController {
  final RxList<UserOrderListModel> userOrderList = RxList<UserOrderListModel>();
  final RxList<ServiceProviderModel> servicesProviderList = RxList<ServiceProviderModel>();
  final RxList<ServiceTakerModel> servicesTakerList = RxList<ServiceTakerModel>();
  final TextEditingController feedBackController = TextEditingController();
  final RxBool isLoading = true.obs;
  final RxBool buttonAction = RxBool(true);
  RxString selectedValue = "Accepted".obs;
  RxString selectedStatus = "Completed".obs;

  RxList<String> statusOptions = [
    "Pending",
    "Accepted",
    "Completed",
    "Cancelled",
  ].obs;
  RxList<String> ChangeStatusOptions = [
    "Pending",
    "Accepted",
    "Completed",
    "Cancelled",
  ].obs;
  var rating = 0.obs;
  var feedback = ''.obs;


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
      servicesProviderList
          .assignAll(response.map((order) => order.serviceProvider));
      servicesTakerList.assignAll(response.map((order) => order.serviceTaker));
    }
  }

  Future<void> changeOrder(String OrderID) async {
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }
    Get.dialog(const LoadingSpinner());

    Map<String, dynamic> data = {
      "status": statusOptions.indexOf(selectedValue.value),
      "st_status": statusOptions.indexOf(selectedValue.value),
      "role": 'service_taker',
    };
    var response = await ApiFetch.changOrderStatus(data, OrderID);
    Get.back();
    buttonAction(true);
    if (response != null && response['success'] == true) {
      userOrderList.clear();
      getUser();
    } else {
      Get.defaultDialog(
        title: 'Data Not Changed',
        middleText: 'Data Not Changed. Please check your Data.',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
  Future<void> addOrderFeedBack(String OrderID) async {
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }
    Get.dialog(const LoadingSpinner());

    Map<String, dynamic> data = {
      "sp_rating":  rating.value,
      "service_provider_feedback": feedBackController.text,
    };
    var response = await ApiFetch.addUserFeedBack(data, OrderID);
    Get.back();
    buttonAction(true);
    if (response != null && response['success'] == true) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.defaultDialog(
        title: 'Data Not Changed',
        middleText: 'Data Not Changed. Please check your Data.',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  Future<void> changeOrderStatusInSummaryPage(String OrderID) async {
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }
    Get.dialog(const LoadingSpinner());

    Map<String, dynamic> data = {
      "status": ChangeStatusOptions.indexOf(selectedStatus.value),
      "st_status": ChangeStatusOptions.indexOf(selectedStatus.value),
      "role": 'service_taker',
    };
    var response = await ApiFetch.changOrderStatus(data, OrderID);
    Get.back();
    buttonAction(true);
    if (response != null && response['success'] == true) {
      Get.defaultDialog(
          title: "Are you Satisfied",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Give us quick rating so we know if you like it?',
                style: Get.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Obx(() {
                return Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < rating.value
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () => setRating(index + 1),
                    );
                  }),
                );
              }),
              TextFormField(
                autovalidateMode:
                AutovalidateMode.onUserInteraction,
                controller: feedBackController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Write your feedback',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.home);
                        },
                        child: Text('Close'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyButton(
                      onTap: () {
                         addOrderFeedBack(OrderID.toString());
                        Get.offAllNamed(AppRoutes.home);
                      },
                      text: 'Submit',
                    ),
                  ),
                ],
              ),
            ],
          ));

    } else {
      Get.defaultDialog(
        title: 'Data Not Changed',
        middleText: 'Data Not Changed. Please check your Data.',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
  void setRating(int value) {
    rating.value = value;
  }

}
