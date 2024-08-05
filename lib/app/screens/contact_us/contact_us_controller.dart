import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../app_assets/debug/debug_pointer.dart';
import '../../../helpers/connectivity.dart';
import '../../../helpers/server/api_fetch.dart';
import '../../../helpers/toaster.dart';
import '../../routes/app_routes.dart';
import '../dialogs/dialog.dart';
import '../my_accounts/models/user_services_model.dart';

class ContactUsController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxList<UserServicesSubDataListModel> userServicesList = RxList<UserServicesSubDataListModel>();
  final Rxn<UserServicesSubDataListModel?> selectedServices = Rxn<UserServicesSubDataListModel?>();
  final TextEditingController selectedServicesTextController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final RxBool isLoading = true.obs;
  final RxBool buttonAction = RxBool(true);
  @override
  void onInit() {
    getUserServices();
    super.onInit();
  }
  Future<void> getUserServices() async {
    isLoading.value = true;
    List<UserServicesSubDataListModel>? response = await ApiFetch.getUserServices();
    isLoading.value = false;
    if (response != null) {
      Debug.log("-------------------------------${response}");
      userServicesList.assignAll(response);
    }
  }
  void savaUserContactUsData() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }

    Get.dialog(const LoadingSpinner());

    // Constructing the data Map with the required fields
    Map<String, dynamic> data = {
      'phone_no': phoneNoController.text,
      'full_name': fullNameController.text,
      'status': selectedServices.value?.id,
    };

    var response = await ApiFetch.saveUserContactUsData(data);
    if (response != null) {
      // final userData = response['message'];
      // Toaster.showToast(userData);
      Get.offAllNamed(AppRoutes.home);
    } else {
      Toaster.showToast('Error Failed to save data');
    }
  }



}