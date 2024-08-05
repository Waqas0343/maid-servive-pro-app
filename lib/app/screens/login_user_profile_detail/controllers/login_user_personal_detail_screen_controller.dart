import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../app_assets/debug/debug_pointer.dart';
import '../../../../helpers/connectivity.dart';
import '../../../../helpers/server/api_fetch.dart';
import '../../../../helpers/toaster.dart';
import '../../../routes/app_routes.dart';
import '../../../services/preferences.dart';
import '../../dialogs/dialog.dart';
import '../../my_accounts/models/currency_model.dart';
import '../../my_accounts/models/languages_model.dart';
import '../../my_accounts/models/user_services_model.dart';

class LoginUserPersonalDetailsController extends GetxController {
  final formValidationKey = GlobalKey<FormState>();
  final TextEditingController selectedServicesTextController = TextEditingController();
  final RxList<GetCurrencyDataListModel> currencyList = RxList<GetCurrencyDataListModel>();
  Rx<GetCurrencyDataListModel?> selectedCurrency = Rx<GetCurrencyDataListModel?>(null);
  final RxList<LanguagesDataListModel> languageList = RxList<LanguagesDataListModel>();
  final Rxn<LanguagesDataListModel?> selectedLanguage = Rxn<LanguagesDataListModel?>();
  final TextEditingController selectedLanguageTextController = TextEditingController();
  final RxList<UserServicesSubDataListModel> userServicesList = RxList<UserServicesSubDataListModel>();
  final Rxn<UserServicesSubDataListModel?> selectedServices = Rxn<UserServicesSubDataListModel?>();
  Rx<DateTime?> selectedDateOfBirth = Rx<DateTime?>(null);
  RxBool autoAcceptRequest = false.obs;
  final RxBool isLoading = true.obs;
  final RxBool buttonAction = RxBool(true);

  final TextEditingController priceController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;



  @override
  void onInit() {
    getUserServices();
    getLanguages();
    getCurrencyList();
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

  Future<void> getCurrencyList() async {
    isLoading.value = true;
    List<GetCurrencyDataListModel>? response = await ApiFetch.getCurrency();
    isLoading.value = false;
    if (response != null) {
      Debug.log("-------------------------------${response}");
      currencyList.assignAll(response);
    }
  }
  Future<void> getLanguages() async {
    isLoading.value = true;
    List<LanguagesDataListModel>? response = await ApiFetch.getLanguages();
    isLoading.value = false;
    if (response != null) {
      Debug.log("-------------------------------${response}");
      languageList.assignAll(response);
    }
  }



  void toggleAutoAcceptRequest(bool value) {
    autoAcceptRequest.value = value;
  }

  void saveProfile() async {
    if (!formValidationKey.currentState!.validate()) return;
    formValidationKey.currentState!.save();
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }
    Get.dialog(const LoadingSpinner());
    Map<String, dynamic> data = {
      "service_types": [
        {
          "service_type_id": selectedServices.value?.id,
          "user_id": userID,
          "experience": experienceController.text,
          "education": educationController.text,
          "price": priceController.text,
          "currency_id": selectedCurrency.value?.id,
          "language_ids": [
            {
              "label": selectedLanguage.value?.name,
              "value":  selectedLanguage.value?.id,
            }
          ],
          "description": descriptionController.text,
          "auto_accept" : autoAcceptRequest.value,
        }
      ]
    };

    var response = await ApiFetch.saveUserServices(data);
    Get.back();
    buttonAction(true);
    if (response != null) {
      final userData = response['message'];
      Toaster.showToast(userData);
      Get.offAllNamed(AppRoutes.loginUserSetAvailability);
    }
  }
}