import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:go_maids_pro/app/routes/app_routes.dart';
import 'package:go_maids_pro/app_assets/debug/debug_pointer.dart';
import 'package:go_maids_pro/helpers/server/api_fetch.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../helpers/connectivity.dart';
import '../../../services/preferences.dart';
import '../../dialogs/dialog.dart';
import '../models/currency_model.dart';
import '../models/get_user_services_informatiom_model.dart';
import '../models/languages_model.dart';
import '../models/user_services_model.dart';

class UserServicesController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxList<UserServicesSubDataListModel> userServicesList = RxList<UserServicesSubDataListModel>();
  final RxList<UserServicesInformationListModel> userServicesInformationList = RxList<UserServicesInformationListModel>();
  final RxList<LanguagesDataListModel> languageList = RxList<LanguagesDataListModel>();
  final RxList<GetCurrencyDataListModel> currencyList = RxList<GetCurrencyDataListModel>();
  final Rxn<UserServicesSubDataListModel?> selectedServices = Rxn<UserServicesSubDataListModel?>();
  final Rxn<GetCurrencyDataListModel?> selectedCurrency = Rxn<GetCurrencyDataListModel?>();
  final Rxn<LanguagesDataListModel?> selectedLanguage = Rxn<LanguagesDataListModel?>();
  final TextEditingController selectedServicesTextController = TextEditingController.fromValue(TextEditingValue());
  final TextEditingController selectedServicesCurrency = TextEditingController();
  final TextEditingController selectedLanguageID = TextEditingController();
  final TextEditingController selectedServicesID = TextEditingController();
  final TextEditingController selectedServicesCurrencyID = TextEditingController();
  final TextEditingController selectedLanguageTextController = TextEditingController();
  final TextEditingController experienceTextController = TextEditingController();
  final TextEditingController educationTextController = TextEditingController();
  final TextEditingController priceTextController = TextEditingController();
  final TextEditingController aboutTextController = TextEditingController();
  int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;
  String dateBirth = Get.find<Preferences>().getString(Keys.userName) ?? "";
  final RxBool isLoading = true.obs;
  final RxBool buttonAction = RxBool(true);
  ServiceproviderService? serviceProvider;
  final RxBool userNeedsToAddServices = RxBool(false);
  RxString showButton = ' '.obs;
  @override
  void onInit() {
    getUserServicesInformation();
    getUserServices();
    getLanguages();
    getCurrencyList();
    super.onInit();
  }



  Future<void> getUserServicesInformation() async {
    try {
      isLoading.value = true;
      List<UserServicesInformationListModel>? response = await ApiFetch.getUserServicesInformation(userID);
      isLoading.value = false;
      if (response != null) {
        userServicesInformationList.assignAll(response);
        if (userServicesInformationList[0].serviceproviderServices.isEmpty) {
          userNeedsToAddServices.value = true;
        } else {
          final serviceProvider = userServicesInformationList[0].serviceproviderServices[0];
          experienceTextController.text = serviceProvider.experience;
          educationTextController.text = serviceProvider.education;
          priceTextController.text = serviceProvider.serviceType.servicePrice.pricePerHour;
          selectedServicesTextController.text = serviceProvider.serviceType.name;
          showButton.value =   selectedServicesTextController.text;
          selectedServicesID.text = serviceProvider.serviceType.id.toString();
          selectedLanguageTextController.text = serviceProvider.serviceType.languageUsers.first.language.name;
          aboutTextController.text = serviceProvider.description;
          selectedServicesCurrency.text = serviceProvider.serviceType.servicePrice.currency.name;
          selectedServicesCurrencyID.text = serviceProvider.serviceType.id.toString();
          selectedLanguage.value?.name = serviceProvider.serviceType.languageUsers.first.language.name;
          selectedLanguageID.text = serviceProvider.serviceType.languageUsers.first.language.id.toString();
        }
      } else {
        userNeedsToAddServices.value = true;
      }
    } catch (error) {
      print('Error fetching user services: $error');
      isLoading.value = false;
    }
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

  Future<void> getLanguages() async {
    isLoading.value = true;
    List<LanguagesDataListModel>? response = await ApiFetch.getLanguages();
    isLoading.value = false;
    if (response != null) {
      languageList.assignAll(response);
    }
  }

  Future<void> getCurrencyList() async {
    isLoading.value = true;
    List<GetCurrencyDataListModel>? response = await ApiFetch.getCurrency();
    isLoading.value = false;
    if (response != null) {
      currencyList.assignAll(response);
    }
  }

  void addServices() async {
    if (userServicesInformationList[0].serviceproviderServices.isEmpty) {
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
        "service_types": [
          {
            "service_type_id": selectedServices.value?.id ?? selectedServicesID.text,
            "user_id": userID,
            "experience": experienceTextController.text,
            "education": educationTextController.text,
            "price": priceTextController.text,
            "currency_id": selectedCurrency.value?.id ?? selectedServicesCurrencyID.text,
            "language_ids": [
              {
                "label": selectedLanguage.value?.name ?? selectedLanguageTextController.text,
                "value": selectedLanguage.value?.id ??  selectedLanguageID.text,
              }
            ],
            "description": aboutTextController.text,
          }
        ]
      };
      var response = await ApiFetch.saveUserServices(data);
      if (response != null) {
        Get.offAllNamed(AppRoutes.home);
      }
    } else {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      buttonAction(false);
      if (!await Connectivity.isOnline()) {
        Connectivity.internetErrorDialog();
        buttonAction.value = true;
        return;
      }
      Get.dialog(const LoadingSpinner());
      var serviceID = selectedServices.value?.id ?? selectedServicesID.text;
      Map<String, dynamic> data = {
        "service_type_id": serviceID,
        "user_id": userID,
        "experience":  experienceTextController.text,
        "description": aboutTextController.text,
        "education": educationTextController.text,
        "price_per_hour": priceTextController.text,
        "currency_id": selectedCurrency.value?.id ?? selectedServicesCurrencyID.text,
        "auto_accept": 0,
        "language_ids": [
          selectedLanguage.value?.id ??  selectedLanguageID.text,
        ]
      };
      var response = await ApiFetch.updateUserServices(data, serviceID);
      Get.back();
      buttonAction(true);
      if (response != null) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.defaultDialog(
          title: 'Data Not Save',
          middleText: 'Data Not Save. Please check your Data.',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
      }
    }
  }
}
