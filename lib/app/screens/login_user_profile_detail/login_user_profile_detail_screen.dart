import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/routes/app_routes.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:image_picker/image_picker.dart';
import '../app_common_widget/my_button.dart';
import 'controllers/login_user_profile_detail_screen_controller.dart';

class LoginUserProfileDetailScreen extends StatelessWidget {
  const LoginUserProfileDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final LoginUserProfileDetailController controller = Get.put(LoginUserProfileDetailController());
    void showProfileBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {

          return  Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "Choose Profile Photo",
                  style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,

                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton.icon(
                      icon: const Icon(Icons.camera,color: Colors.deepPurpleAccent,),
                      onPressed: () {
                        Navigator.pop(context);
                        controller.pickProfileImage(ImageSource.camera);
                      },
                      label:  Text("Camera",  style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurpleAccent,
                      ),),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.image,color: Colors.deepPurpleAccent,),
                      onPressed: () {
                        Navigator.pop(context);
                        controller.pickProfileImage(ImageSource.gallery);
                      },
                      label:  Text("Gallery",  style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurpleAccent,
                      ),),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }

    void showIdentityBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "Choose Identity Photo",
                  style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,

                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton.icon(
                      icon: const Icon(Icons.camera,color: Colors.deepPurpleAccent,),
                      onPressed: () {
                        Navigator.pop(context);
                        controller.pickIdentityImage(ImageSource.camera);
                      },
                      label:  Text("Camera",  style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurpleAccent,
                      ),),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.image,color: Colors.deepPurpleAccent,),
                      onPressed: () {
                        Navigator.pop(context);
                        controller.pickIdentityImage(ImageSource.gallery);
                      },
                      label:  Text("Gallery",  style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurpleAccent,
                      ),),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  await controller.pickDate(controller.dobController);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: controller.dobController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: "Date of Birth",
                      labelStyle: TextStyle(
                        color: Colors.deepOrangeAccent,
                      ),
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.calendar_month_outlined),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Address',
                style: Get.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.0),
              GooglePlacesAutoCompleteTextFormField(
                debounceTime: 300,
                textEditingController: controller.addressController,
                googleAPIKey: controller.apiKey,
                decoration: InputDecoration(
                  hintText: 'Enter address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                itmClick: (prediction) {
                  if (prediction.description!.contains(',')) {
                    controller.addressController.text = prediction.description!;
                    controller
                        .fetchAddressDetails(prediction.description.toString());
                    print('Place selected: ${prediction.description}');
                  }
                },
                onChanged: (input) =>
                    controller.updateAddress(input, controller.apiKey),
              ),
              SizedBox(height: 16.0),
              Text(
                'Location*',
                style: Get.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.countryController,
                textInputAction: TextInputAction.next,
                // readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Enter location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.stateController,
                textInputAction: TextInputAction.next,
                // readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Enter state',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.cityController,
                textInputAction: TextInputAction.next,
                // readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Enter city',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.postalCodeController,
                textInputAction: TextInputAction.next,
                // readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Enter postal code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'User Profile Picture',
                style: Get.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () =>showProfileBottomSheet(context),
                      child: Text('Choose File'),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Obx(
                            () => Text(
                          controller.selectedImageBase64.value == null
                              ? 'No file chosen'
                              : controller.selectedImageBase64.value!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Identity',
                style: Get.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Obx(() => Radio(
                              value: 'driverLicense',
                              groupValue: controller.selectedIdentity.value,
                              onChanged: (value) {
                                controller.selectIdentity(value!);
                                controller.isRadioButtonSelected.value = true;
                              },
                            )),
                        Text('Driver\'s License'),
                        Obx(() => Radio(
                              value: 'passport',
                              groupValue: controller.selectedIdentity.value,
                              onChanged: (value) {
                                controller.selectIdentity(value!);
                                controller.isRadioButtonSelected.value = true;
                              },
                            )),
                        Text('Passport number'),
                      ],
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.isRadioButtonSelected.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0),
                            // Add spacing between radio buttons and "Upload Image" section
                            Text('Upload Image'),
                            SizedBox(height: 8.0),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () =>  showIdentityBottomSheet(context),
                                    child: Text('Choose File'),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Obx(
                                          () => Text(
                                        controller.selectedIdentityImageBase64.value == null
                                            ? 'No file chosen'
                                            : controller.selectedIdentityImageBase64.value!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Column(
                children: [
                  MyButton(
                    color: Colors.red,
                    onTap: () {
                      Get.toNamed(AppRoutes.loginUserPersonalDetail);
                    },
                    text: 'Incomplete Profiles Receive Less Orders',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MyButton(
                    onTap: () {
                      controller.saveProfile();
                    },
                    text: 'Save and Continue',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
