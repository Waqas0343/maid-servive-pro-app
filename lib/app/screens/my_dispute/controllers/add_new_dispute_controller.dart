import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../helpers/connectivity.dart';
import '../../../../helpers/server/api_fetch.dart';
import '../../../../helpers/toaster.dart';
import '../../../routes/app_routes.dart';
import '../../../services/preferences.dart';
import '../../dialogs/dialog.dart';
import '../models/get_user_dispute_model.dart';

class AddNewDisputeController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController selectedOrderTextController = TextEditingController();
  String userName = Get.find<Preferences>().getString(Keys.userName) ?? "";
  int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;
  late RxList<Order> orderList;
  final RxBool buttonAction = RxBool(true);
  final RxBool isLoading = true.obs;
  Order? selected;

  @override
  void onInit() {
    userNameController.text = Get.find<Preferences>().getString(Keys.userName) ?? "";
    List<Order> orderListArg = Get.arguments ?? [];
    orderList = orderListArg.obs;
    super.onInit();
  }

  void addNewDispute() async {
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
        "user_id": userID,
        "order_id": selected?.id.toString(),
        "title": titleController.text,
        "description": descriptionController.text,
        "status": selected?.status,
    };
    // Call the API function
    var response = await ApiFetch.createNewDispute(data);
    if (response != null) {
      final userData = response['message'];
      Toaster.showToast(userData);
      Get.offAllNamed(AppRoutes.home); // Replace '/home' with your home screen route
    } else {
      Toaster.showToast('Error Failed to save data');
    }
  }

}