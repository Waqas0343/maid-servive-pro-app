import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_common_widget/my_button.dart';
import 'controllers/chnage_password_screen_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordScreenController controller = Get.put(ChangePasswordScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: GestureDetector(
        onTap: () => Get.focusScope?.unfocus(),
        child: ListView(
          padding: EdgeInsets.fromLTRB(8.0, 16, 8.0, 8.0),
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.oldPasswordController,
                      obscureText: !controller.isOldPasswordVisible.value,
                      validator: (text) {
                        if (text!.isEmpty) return "Can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Old Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.togglePasswordVisibility('Old');
                          },
                          child: Icon(
                            controller.isOldPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Obx(
                        () => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.newPasswordController,
                      obscureText: !controller.isNewPasswordVisible.value,
                      validator: (text) {
                        if (text!.isEmpty) return "Can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'New Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.togglePasswordVisibility('New');
                          },
                          child: Icon(
                            controller.isNewPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Obx(
                        () => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.confirmPasswordController,
                      obscureText: !controller.isConfirmPasswordVisible.value,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Can't be empty";
                        } else if (text != controller.newPasswordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Confirm Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.togglePasswordVisibility('Confirm');
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
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 25),
                    child: MyButton(
                      text: 'Update Password',
                      onTap: () async {
                        controller.changePassword();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
