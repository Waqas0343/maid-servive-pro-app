import 'dart:io';
import 'package:go_maids_pro/app/screens/app_common_widget/custom_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/screens/signup/signup_controller.dart';
import '../../../helpers/text_formatter.dart';
import '../app_common_widget/my_button.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpScreenController controller = Get.put(SignUpScreenController());
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: h / 3,
                  width: 450,
                  child: Image.asset(
                    'assets/images/loginlogo.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 95,
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 65.0,
                          backgroundImage: controller.imageFile == null
                              ? AssetImage("assets/images/user.png")
                              : FileImage(File(controller.imageFile!.path))
                                  as ImageProvider,
                          backgroundColor: Colors.white,
                        ),
                        Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: ClipOval(
                            child: Material(
                              color: Colors.grey[400],
                              child: InkWell(
                                splashColor: Colors.red,
                                onTap: () {
                                  Get.bottomSheet(
                                    CustomCard(
                                      child: Container(
                                        height: 200.0,
                                        width: Get.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Column(
                                          children: <Widget>[
                                            const Text(
                                              "Choose Profile photo",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                TextButton.icon(
                                                  icon:
                                                      const Icon(Icons.camera),
                                                  onPressed: () {
                                                    Get.back();
                                                    controller.takePhoto(
                                                        ImageSource.camera);
                                                  },
                                                  label: const Text("Camera"),
                                                ),
                                                TextButton.icon(
                                                  icon: const Icon(Icons.image),
                                                  onPressed: () {
                                                    Get.back();
                                                    controller.takePhoto(
                                                        ImageSource.gallery);
                                                  },
                                                  label: const Text("Gallery"),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    margin: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: GestureDetector(
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Colors.white),
                    onTap: () => Get.back(),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 15,
                  child: Text(
                    'Information',
                    style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "E-mail Address *",
                        suffixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "E-mail address cannot be empty";
                        } else if (!TextInputFormatterHelper.validEmail
                            .hasMatch(text)) {
                          return "Invalid E-mail address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autofillHints: const [AutofillHints.password],
                      controller: controller.firstNameController,
                      validator: (text) {
                        if (text!.isEmpty) return "Can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'First Name *',
                        suffixIcon: Icon(Icons.person_outline_rounded),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autofillHints: const [AutofillHints.password],
                      controller: controller.lastNameController,
                      validator: (text) {
                        if (text!.isEmpty) return "Can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'FLast Name *',
                        suffixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autofillHints: const [AutofillHints.password],
                      controller: controller.userNameController,
                      validator: (text) {
                        if (text!.isEmpty) return "Can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Username *',
                        suffixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autofillHints: const [AutofillHints.password],
                        controller: controller.passwordController,
                        obscureText: !controller.isPasswordVisible.value,
                        validator: (text) {
                          if (text!.isEmpty) return "Can't be empty";
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Password *',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.togglePasswordVisibility();
                            },
                            child: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autofillHints: const [AutofillHints.password],
                        controller: controller.confirmPasswordController,
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Can't be empty";
                          } else if (text !=
                              controller.passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Confirm password *',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.toggleConfirmPasswordVisibility();
                            },
                            child: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    GestureDetector(
                      onTap: () =>
                          controller.pickDate(controller.dateOfBirthController),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: controller.dateOfBirthController,
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
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 25),
                      child: MyButton(
                        text: 'Register',
                        onTap: () async {
                          controller.signUp();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
