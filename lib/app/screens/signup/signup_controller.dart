import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app_assets/debug/debug_pointer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../helpers/connectivity.dart';
import '../../../helpers/server/api_fetch.dart';
import '../../routes/app_routes.dart';
import '../../services/preferences.dart';
import '../dialogs/dialog.dart';

class SignUpScreenController extends GetxController {
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  final RxBool buttonAction = RxBool(true);
  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final DateFormat dateFormat = DateFormat(Keys.dateFormat);
  final DateFormat timeFormat = DateFormat(Keys.timeFormat);
  bool hasError = false;
  String errorText = '';
  DateTime dateTime = DateTime.now();
  String? selectedDate1;
  DateTime selectedDate2 = DateTime.now();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void signUp() async {
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
      "email": emailController.text,
      "fname": firstNameController.text,
      'lname': lastNameController.text,
      'username': userNameController.text,
      'password': passwordController.text,
      "role_id": "2"
    };

    var response = await ApiFetch.usersSignUp(data);
    Get.back();
    buttonAction(true);
    if (response != null && response['success'] == true) {
      final userData = response['data'];
      if (response['message'] == 'Data has been Saved Successfully') {
        Get.find<Preferences>().setString(Keys.isToken, userData['accessToken']);
        Get.find<Preferences>().setInt(Keys.userId, userData['id']);
        Get.find<Preferences>().setString(Keys.userName, userData['username']);
        Get.find<Preferences>().setString(Keys.fullName, userData['fullName']);
        Get.find<Preferences>().setString(Keys.email, userData['email']);
        Get.find<Preferences>().setString(Keys.userImage, userData['image']);
        Debug.log("....................................... ${userData['accessToken']} ................................................. ");
        Get.offAllNamed(AppRoutes.emailVerify, arguments: {'email': userData['email']});
      } else {
        Get.defaultDialog(
          title: 'Signup Failed',
          middleText: response['message'],
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
      }
    }
  }

  Future<void> pickDate(TextEditingController dateController) async {
    DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(0),
      lastDate: DateTime.now().add(
        const Duration(minutes: 10),
      ),
    );

    if (date != null) {
      dateController.text = dateFormat.format(date);
      dateTime = date;
    }
  }


  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
    );
    imageFile = pickedFile;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
    isConfirmPasswordVisible.value = false;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
    isPasswordVisible.value = false;
  }
}
