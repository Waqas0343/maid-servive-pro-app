import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/screens/payment/payment_information_model.dart';
import 'package:intl/intl.dart';

import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../helpers/connectivity.dart';
import '../../../helpers/server/api_fetch.dart';
import '../../../helpers/toaster.dart';
import '../../routes/app_routes.dart';
import '../../services/preferences.dart';
import '../dialogs/dialog.dart';

class PaymentScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DateFormat dateFormat = DateFormat(Keys.dateFormat);
  final DateFormat timeFormat = DateFormat(Keys.timeFormat);
  DateTime dateTime = DateTime.now();
  var selectedMethod = PaymentMethod.Stripe.obs;
  final addressController = TextEditingController();
  final accountNumberController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final stripeClientIDController = TextEditingController();
  final stripeSecretKeyController = TextEditingController();
  final paypalClientIDController = TextEditingController();
  final paypalSecretKeyController = TextEditingController();
  final RxBool buttonAction = RxBool(true);
  final RxString selectedBankType = 'individual'.obs;
  final List<String> lineSectionName = [
    'individual',
    'company',
    'non_profit',
    ' government_entity',
  ];
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    dobController.text = dateFormat.format(dateTime);
    firstNameController.text = Get.find<Preferences>().getString(Keys.firstName) ?? "";
    lastNameController.text = Get.find<Preferences>().getString(Keys.lastName) ?? "";
    emailController.text = Get.find<Preferences>().getString(Keys.email) ?? "";
    emailController.text = Get.find<Preferences>().getString(Keys.isPhoneNumber) ?? "";
    getUserProfile();
    super.onInit();
  }

  Future<void> getUserProfile() async {
    isLoading.value = true;
    PaymentModel? response = await ApiFetch.getPaymentInformation();
    isLoading.value = false;
    if (response != null && response.success) {
      stripeClientIDController.text = response.data.stripePublishableKey ?? '';
      stripeSecretKeyController.text = response.data.stripeSecret ?? '';
      paypalClientIDController.text = response.data.paypalClientId ?? '';
      paypalSecretKeyController.text = response.data.paypalClientSecret ?? '';
    } else {
      Toaster.showToast(response!.message);
    }
  }

  void addStripePaymentMethod() async {
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
      "stripe_publishable_key": stripeClientIDController.text,
      "stripe_secret": stripeSecretKeyController.text,
    };
    // Call the API function
    var response = await ApiFetch.configurePaymentMethod(data);
    if (response != null) {
      final userData = response['message'];
      Toaster.showToast(userData);
      Get.offAllNamed(AppRoutes.home);
    } else {
      Toaster.showToast('Error Failed to save data');
    }
  }

  void addPaypalPaymentMethod() async {
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
      "paypal_client_id": paypalClientIDController.text,
      "paypal_client_secret": paypalSecretKeyController.text
    };
    // Call the API function
    var response = await ApiFetch.configurePaymentMethod(data);
    if (response != null) {
      final userData = response['message'];
      Toaster.showToast(userData);
      Get.offAllNamed(AppRoutes.home);
    } else {
      Toaster.showToast('Error Failed to save data');
    }
  }

  void addBankPaymentMethod() async {
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
      "account_number": accountNumberController.text,
      "account_type": selectedBankType.value,
      "fname": firstNameController.text,
      "lname": lastNameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "dob": dobController.text,
      "addres": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "country": countryController.text,
      "postal_code": postalCodeController.text,
    };
    var response = await ApiFetch.configureBankPaymentMethod(data);
    if (response != null) {
      if (response['success'] == true) {
        final userData = response['message'];
        Toaster.showToast(userData);
        Get.offAllNamed(AppRoutes.home);
      } else {
        final errorMessage = response['message'];
        if (errorMessage == "\"923014376846\" is not a valid phone number") {
          Toaster.showToast("Please enter a valid phone number");
        } else {
          Toaster.showToast(errorMessage);
        }
      }
    } else {
      Toaster.showToast("Unknown error occurred");
    }
    Get.back();
  }

  Future<void> pickFromDate() async {
    DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(
        const Duration(minutes: 10),
      ),
    );
    if (date != null) {
      dobController.text = dateFormat.format(date);
      dateTime = date;
    }
  }
}
enum PaymentMethod { Stripe, Paypal, Bank }