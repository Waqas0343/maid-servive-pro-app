import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../helpers/crypto_helper.dart';
import '../../../../helpers/server/api_fetch.dart';
import '../../../app_assets/debug/debug_pointer.dart';
import '../../../helpers/connectivity.dart';
import '../../routes/app_routes.dart';
import '../../services/preferences.dart';
import '../app_common_widget/app_dialog_confirmation.dart';
import '../dialogs/dialog.dart';

class LoginController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController loginIDController = TextEditingController();
  final RxBool buttonAction = RxBool(true);
  final formKey = GlobalKey<FormState>();
  var isPasswordVisible = false.obs;
  final rememberMe = false.obs;
  String? emailID;
  String? password;


  void login() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    buttonAction(false);
    // Connectivity checking
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }
    Get.dialog(const LoadingSpinner());
    Map<String, dynamic> data = {
      "email": emailID,
      "password": password,
      'role': 'service_provider',
    };

    var response = await ApiFetch.login(data);
    Get.back();
    buttonAction(true);
    if (response != null) {
      final userData = response['data'];
      // Save user information into SharedPreferences
      Get.find<Preferences>().setString(Keys.isToken, userData['accessToken']);
      Get.find<Preferences>().setInt(Keys.userId, userData['id']);
      Get.find<Preferences>().setString(Keys.userName, userData['username']);
      Get.find<Preferences>().setString(Keys.fullName, userData['fullName']);
      Get.find<Preferences>().setString(Keys.email, userData['email']);
      Get.find<Preferences>().setString(Keys.userImage, userData['image']);
      Get.find<Preferences>().setBool(Keys.status, true);
      Debug.log(userData['username']);
      Get.offAllNamed(AppRoutes.home);
    } else {
      ConfirmationAlert.showDialog(
        title: "Login Failed",
        description: "Failed to log in. Please check your credentials and try again.",
        onConfirm: () {
        },
      );
    }
  }


  void toggleRememberMe(bool? value) {
    if (value != null) {
      rememberMe.value = value;
      Get.find<Preferences>().setBool(Keys.rememberMe, rememberMe.value);
    }
  }

  void saveLoginCredentials(String value) {
    if (rememberMe.value) {
      String? encyPassword = password != null ? CryptoHelper.encryption(password!) : null;
      Get.find<Preferences>().setString(Keys.password, encyPassword);
      Get.find<Preferences>().setString(Keys.userId, emailID);
    }
  }
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
