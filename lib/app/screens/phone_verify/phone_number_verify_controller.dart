import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/debug/debug_pointer.dart';
import '../../../helpers/connectivity.dart';
import '../../../helpers/server/api_fetch.dart';
import '../../routes/app_routes.dart';
import '../../services/preferences.dart';
import '../dialogs/dialog.dart';

class PhoneVerifyController extends GetxController {
  final phoneController = TextEditingController();
  final pinController = TextEditingController();
  final RxBool otpSendingLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final RxBool showDialog = false.obs;
  var selectedCountryCode = "+1".obs;
  final RxString email = ''.obs;
  final focusNode = FocusNode();
  final isLoading = false.obs;
  String? phoneNumber;
  RxBool isValid = true.obs;
  RxString verificationCode = RxString('');

  @override
  void onInit() {
    final arguments = Get.arguments as Map<String, dynamic>;
    email.value = arguments['email'];
    super.onInit();
  }

  void sendCodeToMobile(String? phoneNumber, String? email) async {
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      return;
    }
    Get.dialog(const LoadingSpinner());
    Get.find<Preferences>().setString(Keys.isPhoneNumber, '${selectedCountryCode}$phoneNumber');
    Map<String, dynamic> data = {
      "email": email,
      "mobile_no": '${selectedCountryCode}$phoneNumber',
    };
    var response = await ApiFetch.sendCodeToMobile(data);
    if (response != null) {
      Get.back();
      showDialog.value = true;
    } else {
      Get.defaultDialog(
        title: 'Failed To Send',
        middleText:
            'Failed to Send Code. Please check your credentials and try again.',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  void verifyPhoneCode(String verificationCode) async {
    if (!otpSendingLoading.value) {
      otpSendingLoading.value = true;
    }

    if (!await Connectivity.isOnline()) {
      otpSendingLoading.value = false;
      Connectivity.internetErrorDialog();
      return;
    }
    String phone = Get.find<Preferences>().getString(Keys.isPhoneNumber) ?? "";
    Get.dialog(const LoadingSpinner());
    Map<String, dynamic> data = {
      "mobile_no": phone,
      "otp": verificationCode
    };
    var response = await ApiFetch.verifyMobilePinCode(data);
    Get.back();

    if (response != null && response['success'] == true) {
      Get.find<Preferences>().setString(Keys.email, response['data']['email']);
      Get.find<Preferences>().setString(Keys.isPhoneNumber, response['data']['mobile_no']);
      Debug.log(response['data']['mobile_no']);
      otpSendingLoading.value = false;
      Get.toNamed(AppRoutes.loginUserProfileDetail);
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
