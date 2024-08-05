import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../app_assets/debug/debug_pointer.dart';
import '../../../../helpers/connectivity.dart';
import '../../../../helpers/server/api_fetch.dart';
import '../../../../helpers/toaster.dart';
import '../../../routes/app_routes.dart';
import '../../../services/preferences.dart';
import '../../app_common_widget/app_dialog_confirmation.dart';
import '../../dialogs/dialog.dart';
import '../models/user_profile_model.dart';

class UserProfileController extends GetxController {
  final RxList<UserProfileDataModel> userList = RxList<UserProfileDataModel>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final DateFormat dateFormat = DateFormat(Keys.dateFormat);
  String dob = Get.find<Preferences>().getString(Keys.dob) ?? "";
  final RxBool buttonAction = RxBool(true);
  final RxBool autoAccept = false.obs;
  int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;
  final RxBool isLoading = true.obs;
  final picker = ImagePicker();
  Rx<File?> profilePicture = Rx<File?>(null);
  Rx<File?> identityPicture = Rx<File?>(null);
  Rx<String?> selectedImageBase64 = Rx<String?>(null);
  Rx<String?> selectedIdentityImageBase64 = Rx<String?>(null);
  String email = Get.find<Preferences>().getString(Keys.email) ?? "";
  DateTime dateTime = DateTime.now();
  final String apiKey = 'AIzaSyDxLxPEKkM9vuuAJpTQuWJBCcfLmZKlDmI';
  @override
  void onInit() {
    getUserProfile();
    super.onInit();
  }
  Future<void> getUserProfile() async {
    isLoading.value = true;
    try {
      UserProfileModel? response = await ApiFetch.getUserProfile(userID);
      isLoading.value = false;
      if (response != null && response.success) {

        if (response.data.isEmailVerified.isEmpty && response.data.isMobileVerified.isEmpty) {
          Get.dialog(
            AlertDialog(
              title: Text('Complete Profile'),
              content: Text('Please Complete Your Profile To Continue.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.emailVerify, arguments: {'email': email});
                  },
                  child: Text('Complete Profile'),
                ),
              ],
            ),
          );
        }
        emailController.text = response.data.email;
        usernameController.text = response.data.username;
        firstNameController.text = response.data.fname;
        lastNameController.text = response.data.lname;
        phoneController.text = response.data.mobileNo;
        countryController.text = response.data.location.country;
        addressController.text = response.data.location.streetAddress;
        dobController.text =  dateFormat.format(DateTime.parse(response.data.dob.toString()));
        provinceController.text = response.data.location.state.toString();
        cityController.text = response.data.location.city.toString();
        postalCodeController.text = response.data.location.postalCode.toString();
        autoAccept.value = response.data.serviceProviders.isNotEmpty
            ? response.data.serviceProviders[0]['auto_accept'] == "1"
            : false;

        profilePicture.value = File(response.data.image);
        profilePicture.value = profilePicture.value;
        Debug.log('Profile ------------------------------------------------------------ ${profilePicture.value}');
        identityPicture.value = response.data.identity.isNotEmpty
            ? File(response.data.identity)
            : null;
        Debug.log('Identity ------------------------------------------------------------${identityPicture.value}');
        Debug.log('email ------------------------------------------------------------${email}');

      } else {
        Get.snackbar('Error', 'Failed to fetch user profile');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An error occurred while fetching user profile');
      print('Error fetching user profile: $e');
    }
  }

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
          provinceController.text = state;
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

  String imageToBase64String(Uint8List imageBytes) {
    return 'data:image/jpeg;base64,' + base64Encode(imageBytes);
  }
  void takeProfilePhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      profilePicture.value = File(pickedFile.path);
      profilePicture.value = profilePicture.value;
      final bytes = await File(pickedFile.path).readAsBytes();
      selectedImageBase64.value = imageToBase64String(bytes);
      update();
    }
  }
  String identityImageToBase64String(Uint8List imageBytes) {
    return 'data:image/jpeg;base64,' + base64Encode(imageBytes);
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null)
    {
      identityPicture.value = File(pickedFile.path);
      identityPicture.value = identityPicture.value;
      final bytes = await File(pickedFile.path).readAsBytes();
      selectedIdentityImageBase64.value = identityImageToBase64String(bytes);
  update();
    }
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


  void saveProfile() async {
    buttonAction(false);
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      return;
    }
    Get.dialog(const LoadingSpinner());
    Debug.log('Selected Image Base64: ${selectedImageBase64.value}');
    Debug.log('Selected Identity Image Base64: ${selectedIdentityImageBase64.value}');
    Map<String, dynamic> data = {
      "email": emailController.text,
      "fname": firstNameController.text,
      'lname': lastNameController.text,
      "mobile_no": phoneController.text,
      "street_address": addressController.text,
      "city": cityController.text,
      "state": provinceController.text,
      "country": countryController.text,
      "user_id": userID,
      "postal_code": postalCodeController.text,
      "default_address": addressController.text,
      "dob": dobController.text,
      "image": selectedImageBase64.value,
      "identity": selectedIdentityImageBase64.value,
      "auto_accept": autoAccept.value
    };

    var response = await ApiFetch.saveUserProfileDetail(data);
    Get.back();
    buttonAction(true);

    // Check the response from the server
    if (response != null) {
      final userData = response['message'];
      Toaster.showToast(userData);
      Get.offAllNamed(AppRoutes.home);
    }
  }

}
