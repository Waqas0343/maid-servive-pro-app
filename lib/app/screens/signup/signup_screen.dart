import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/screens/signup/signup_controller.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import '../../../app_assets/app_styles/my_images.dart';
import '../../../helpers/text_formatter.dart';
import '../../routes/app_routes.dart';
import '../app_common_widget/my_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                  child: Image.asset(
                    MyImages.logo,
                    height: 150,
                    width: 150,
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
                  left: 25,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 25, color: Colors.white),
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
                        labelText: 'Last Name *',
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
                    Text(
                      "Password must includes at least one lower case, one upper case, one special character and length should be in between 6-25.",
                      style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: MyColors.shimmerBaseColor
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
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account "),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.login);
                            },
                            child: Text(
                              'Sign In',
                              style: Get.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.blueColor),
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
    );
  }
}
