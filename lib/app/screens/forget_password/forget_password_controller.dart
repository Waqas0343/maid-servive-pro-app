import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/connectivity.dart';
import '../../../helpers/server/api_fetch.dart';
import '../../routes/app_routes.dart';
import '../dialogs/dialog.dart';

class ForgetPassController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final RxBool buttonAction = RxBool(true);

  Future<void> resetPassword() async {
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
      "email": emailController.text,
    };
    var response = await ApiFetch.forgotPassword(data);
    Get.back();
    buttonAction(true);
    if (response != null) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.defaultDialog(
        title: 'Login Failed',
        middleText: 'Failed to log in. Please check your credentials and try again.',
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}