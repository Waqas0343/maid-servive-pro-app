import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app_assets/debug/debug_pointer.dart';
import 'package:go_maids_pro/helpers/server/api_fetch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../helpers/connectivity.dart';
import '../../../routes/app_routes.dart';
import '../../../services/preferences.dart';
import '../../dialogs/dialog.dart';

class LoginUserProfileDetailController extends GetxController {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isRadioButtonSelected = false.obs;
  final RxBool buttonAction = RxBool(true);
  final String apiKey = 'AIzaSyDxLxPEKkM9vuuAJpTQuWJBCcfLmZKlDmI';
  RxString selectedIdentity = ''.obs;
  int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;
  void selectIdentity(String identity) {
    selectedIdentity.value = identity;
  }
  final DateFormat dateFormat = DateFormat(Keys.dateFormat);
  DateTime dateTime = DateTime.now();
  final ImagePicker _picker = ImagePicker();
  Rx<File?> profileImagePath = Rx<File?>(null);
  Rx<File?> identityImagePath = Rx<File?>(null);
  Rx<String?> selectedImageBase64 = Rx<String?>(null);
  Rx<String?> selectedIdentityImageBase64 = Rx<String?>(null);

  void updateAddress(String input, String apiKey) async {
    try {
      final predictions = await ApiFetch.getAutocompletePredictions(input, apiKey);
      final predictionsText = predictions.join(', ');
      addressController.text = predictionsText;
    } catch (e) {
      print('Error: $e');
    }
  }



  Future<void> fetchAddressDetails(String address) async {
    try {
      final String apiKey = 'AIzaSyCBl-mGeYwZqQcE3oZbnbDKBe0bqIaf9lM';
      final String encodedAddress = Uri.encodeComponent(address);
      final String apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&9sen-US&r_url=https%3A%2F%2Fgomaidz.com%2FUserdashboard&callback=_xdc_._kacyja&key=$apiKey&token=62630';
      Debug.log(apiUrl);
      final response = await Dio().get(apiUrl);
      if (response.statusCode == 200) {
        final decodedResponse = response.data;
        Debug.log(decodedResponse);
        final results = decodedResponse['results'];
        Debug.log(results);
        if (results != null && results.isNotEmpty) {
          final result = results[0];
          final addressComponents = result['address_components'];
          final country = _extractComponent(addressComponents, 'country');
          final state = _extractComponent(addressComponents, 'administrative_area_level_1');
          final city = _extractComponent(addressComponents, 'locality');
          final postalCode = _extractComponent(addressComponents, 'postal_code');

          countryController.text = country;
          stateController.text = state;
          cityController.text = city;
          postalCodeController.text = postalCode;
        } else {
          throw Exception('No results found');
        }
      } else {
        throw Exception('Failed to fetch address details: ${response.statusCode}');
      }
    } catch (e) {
      // Toaster.showToast('Error fetching address details: $e');
      print('Error fetching address details: $e');
    }
  }

  String _extractComponent(List<dynamic> components, String componentType) {
    for (var component in components) {
      final types = component['types'];
      if (types != null && types.contains(componentType)) {
        return component['long_name'];
      }
    }
    return '';
  }
  Future<void> pickDate(TextEditingController dateController) async {
    DateTime now = DateTime.now();
    DateTime eighteenYearsAgo = DateTime(now.year - 18, now.month, now.day);

    DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: eighteenYearsAgo,
      firstDate: DateTime(1900), // or any other suitable first date
      lastDate: eighteenYearsAgo,
    );

    if (date != null) {
      dateController.text = dateFormat.format(date);
      dateTime = date;
    }
  }
  String imageToBase64String(Uint8List imageBytes) {
    return 'data:image/jpeg;base64,' + base64Encode(imageBytes);
  }
  Future<void> pickProfileImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      profileImagePath.value = File(pickedFile.path);
      final bytes = await File(pickedFile.path).readAsBytes();
      selectedImageBase64.value = imageToBase64String(bytes);
    }
  }
  String identityImageToBase64String(Uint8List imageBytes) {
    return 'data:image/jpeg;base64,' + base64Encode(imageBytes);
  }
  Future<void> pickIdentityImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      identityImagePath.value = File(pickedFile.path);
      final bytes = await File(pickedFile.path).readAsBytes();
      selectedIdentityImageBase64.value = identityImageToBase64String(bytes);
      Debug.log('......................................${selectedIdentityImageBase64.value}');
    }
  }

  void saveProfile() async {
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
      "street_address": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "country": countryController.text,
      "user_id": userID,
      "postal_code": postalCodeController.text,
      "default_address": addressController.text,
      "dob": dobController.text,
      "image": selectedImageBase64.value ?? '', // Use the base64 string obtained from pickProfileImage
      "identity": selectedIdentityImageBase64.value ?? '', // Use the base64 string obtained from pickIdentityImage
    };

    print('API Data: $data');

    var response = await ApiFetch.saveUserProfileDetail(data);
    Get.back();
    buttonAction(true);
    if (response != null) {
      final userData = response['message'];
      Debug.log(userData);
      Get.toNamed(AppRoutes.loginUserPersonalDetail);
    }
  }



  @override
  void onClose() {
    addressController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    super.onClose();
  }
}