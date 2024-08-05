import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/routes/app_routes.dart';
import '../../../helpers/connectivity.dart';
import '../../../helpers/server/api_fetch.dart';
import '../dialogs/dialog.dart';

class EmailVerifyController extends GetxController {
  final pinController = TextEditingController();
  final RxString email = ''.obs;
  final RxBool otpSendingLoading = false.obs;
  final focusNode = FocusNode();
  final RxBool showDialog = false.obs;
  RxString profilePictureUrl = ''.obs;
  RxBool isValid = true.obs;
  RxString verificationCode = RxString('');

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    email.value = arguments['email'];
  }

  void sendEmailOtp() async {
    if (!otpSendingLoading.value) {
      otpSendingLoading.value = true;
    }
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      return;
    }
    Get.dialog(const LoadingSpinner());
    Map<String, dynamic> data = {
      "email": email.value,
    };
    var response = await ApiFetch.sendCodeToMail(data);
    if (response != null) {
      final userData = response['data'];
      profilePictureUrl.value = userData['image'];
      Get.back();
      showDialog.value = true;
    } else {
      Get.defaultDialog(
        title: 'Login Failed',
        middleText:
        'Failed to log in. Please check your credentials and try again.',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  void verifyEmailCodeEmailCode(String verificationCode) async {
    if (!otpSendingLoading.value) {
      otpSendingLoading.value = true;
    }

    if (!await Connectivity.isOnline()) {
      otpSendingLoading.value = false;  // Reset loading state if there's no internet
      Connectivity.internetErrorDialog();
      return;
    }

    Get.dialog(const LoadingSpinner());

    Map<String, dynamic> data = {
      "email": email.value,
      "code": verificationCode,
    };

    var response = await ApiFetch.verifyMailPinCode(data);
    Get.back();  // Close the LoadingSpinner dialog

    if (response != null && response['success'] == true) {
      final userData = response['data'];
      profilePictureUrl.value = userData['image'];
      otpSendingLoading.value = false;
      Get.toNamed(AppRoutes.phoneVerify, arguments: {'email': email.value});
    } else {
      otpSendingLoading.value = false;
      Get.defaultDialog(
        title: 'Verification Failed',
        middleText: response != null ? response['message'] : 'Failed to verify. Please try again.',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  bool validateCode(String code) {
    return code.isNotEmpty && RegExp(r'^[0-9]+$').hasMatch(code);
  }
}
