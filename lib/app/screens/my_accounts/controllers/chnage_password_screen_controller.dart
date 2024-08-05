import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/helpers/toaster.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../helpers/connectivity.dart';
import '../../../../helpers/server/api_fetch.dart';
import '../../../routes/app_routes.dart';
import '../../../services/preferences.dart';
import '../../dialogs/dialog.dart';

class ChangePasswordScreenController extends GetxController{
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;
  final RxBool buttonAction = RxBool(true);
  final formKey = GlobalKey<FormState>();
  var isConfirmPasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;
  var isOldPasswordVisible = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }
    Get.dialog(const LoadingSpinner());
    Map<String, dynamic> data = {
      "user_id": userID,
      "password": oldPasswordController.text,
      "newpassword": newPasswordController.text,
    };
    var response = await ApiFetch.changeUserPassword(data);
    Get.back();
    buttonAction(true);
    if (response != null && response.success) {
      // Toaster.showToast(response.message);
      final userData = response.data;
      if (response.message == 'Password changed Successfully') {
        Get.find<Preferences>().setInt(Keys.userId, userData.id);
        Get.find<Preferences>().setString(Keys.userName, userData.username);
        Get.find<Preferences>().setString(Keys.firstName, userData.fname);
        Get.find<Preferences>().setString(Keys.lastName, userData.lname);
        Get.find<Preferences>().setString(Keys.email, userData.email);
        Get.find<Preferences>().setString(Keys.isPhoneNumber, userData.mobileNo);
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }


  void togglePasswordVisibility(String passwordType) {
    switch (passwordType) {
      case 'Old':
        isOldPasswordVisible.value = !isOldPasswordVisible.value;
        break;
      case 'New':
        isNewPasswordVisible.value = !isNewPasswordVisible.value;
        break;
      case 'Confirm':
        isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
        break;
      default:
        throw ArgumentError('Invalid password type: $passwordType');
    }
  }

}