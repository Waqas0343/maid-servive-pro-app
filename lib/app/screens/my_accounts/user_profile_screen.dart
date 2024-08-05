import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app_assets/app_styles/my_colors.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app_assets/app_styles/my_images.dart';
import '../app_common_widget/my_button.dart';
import 'controllers/user_profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final UserProfileController userProfileController = Get.put(UserProfileController());
    Widget bottomSheet(BuildContext context) {
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
                    userProfileController.takePhoto(ImageSource.camera);
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
                    userProfileController.takePhoto(ImageSource.gallery);
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
    }
    Widget bottomSheetForProfile(BuildContext context) {
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
                  icon: const Icon(Icons.camera, color: Colors.deepPurpleAccent,),
                  onPressed: () {
                    Navigator.pop(context);
                    userProfileController.takeProfilePhoto(ImageSource.camera);
                  },
                  label:  Text("Camera",   style: Get.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurpleAccent,
                  ), ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.image, color: Colors.deepPurpleAccent,),
                  onPressed: () {
                    Navigator.pop(context);
                    userProfileController.takeProfilePhoto(ImageSource.gallery, );
                  },
                  label:  Text("Gallery",   style: Get.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurpleAccent,
                  ),),
                ),
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              MyImages.logo,
              color: Colors.white,
              height: 100.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => bottomSheetForProfile(context),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Obx(() {
                          final String? profileImagePath = userProfileController.profilePicture.value?.path;
                          final String profileImageUrl = 'https://maid-service.tecrux.solutions/public/$profileImagePath';
                          print('Profile Image Path: $profileImagePath');
                          print('Profile Image URL: $profileImageUrl');

                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: profileImagePath != null
                                    ? NetworkImage(profileImageUrl)
                                    : AssetImage('assets/images/user.png') as ImageProvider<Object>,
                              ),
                              if (profileImagePath == null)
                                CircularProgressIndicator(
                                  color: MyColors.shimmerBaseColor,
                                ),
                            ],
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          // Add some padding to the camera icon
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors
                                  .white, // White color for the background
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              // Adjust padding as needed
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black, // Icon color
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'User Information',
              style: Get.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              readOnly: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Email',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: userProfileController.emailController,
            ),
            SizedBox(height: 10),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: userProfileController.usernameController,
            ),
            SizedBox(height: 10),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: userProfileController.firstNameController,
            ),
            SizedBox(height: 10),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: userProfileController.lastNameController,
            ),
            SizedBox(height: 10),
            Divider(),
            Row(
              children: [
                Text(
                  'Add your driver licence or passport image',
                  style: Get.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => bottomSheet(context),
                    );
                  },
                ),
              ],
            ),
            Obx(() {
              final String imagePath = userProfileController.identityPicture.value?.path ?? '';
              final String imageUrl = 'https://maid-service.tecrux.solutions/public/$imagePath';

              return Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: userProfileController.identityPicture.value != null
                        ? NetworkImage(imageUrl)
                        : null,
                  ),
                  Visibility(
                    visible: userProfileController.identityPicture.value == null,
                    child: SizedBox.shrink(),
                  ),
                ],
              );
            }),
            SizedBox(height: 10),
            Divider(),
            Text(
              'Personal Information',
              style: Get.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              textInputAction: TextInputAction.next,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: userProfileController.phoneController,
            ),
            SizedBox(height: 10),

            GestureDetector(
              onTap: () => userProfileController.pickDate(userProfileController.dobController),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: userProfileController.dobController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    label: Text(
                      "Date of Birth",
                    ),
                    hintText: "Date of Birth",
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GooglePlacesAutoCompleteTextFormField(
              debounceTime: 300,
              maxLines: 3,
              textEditingController: userProfileController.addressController,
              googleAPIKey: userProfileController.apiKey,
              decoration: InputDecoration(
                hintText: 'Enter address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              itmClick: (prediction) {
                if (prediction.description!.contains(',')) {
                  userProfileController.addressController.text = prediction.description!;
                  userProfileController.fetchAddressDetails(prediction.description.toString());
                  print('Place selected: ${prediction.description}');
                }
              },
              onChanged: (input) => userProfileController.updateAddress(input, userProfileController.apiKey),
            ),
            SizedBox(height: 10),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: userProfileController.countryController,
            ),
            SizedBox(height: 10),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Province',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: userProfileController.provinceController,
            ),
            SizedBox(height: 10),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: userProfileController.cityController,
            ),
            SizedBox(height: 10),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Postal Code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: userProfileController.postalCodeController,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Automatically accept incoming orders'),
                Obx(
                  () => Switch(
                    value: userProfileController.autoAccept.value,
                    onChanged: (value) =>
                        userProfileController.autoAccept.toggle(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Row(
                children: [
                  Flexible(
                    child: MyButton(
                      text: 'Save',
                      onTap: () async {
                        userProfileController.saveProfile();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
