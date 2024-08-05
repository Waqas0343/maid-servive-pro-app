import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/routes/app_routes.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import '../../../app_assets/app_styles/my_images.dart';
import '../../../helpers/text_formatter.dart';
import '../app_common_widget/my_button.dart';
import 'login_screen_controller.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 40 * h,
                  width: 450,
                  child: Image.asset(
                    'assets/images/loginlogo2.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  right: 6 * w,
                  top: 19 * h,
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
                    child: Icon(Icons.arrow_back_rounded, color: Colors.white),
                    onTap: () => Get.back(),
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 35,
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutofillGroup(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: controller.loginIDController,
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
                            onSaved: (text) => controller.emailID = text,
                            onChanged: controller.saveLoginCredentials,
                          ),
                          const SizedBox(height: 12.0),
                          Obx(
                            () => TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofillHints: const [AutofillHints.password],
                              controller: controller.passwordController,
                              obscureText: !controller.isPasswordVisible.value,
                              validator: (text) {
                                if (text!.isEmpty) return "Can't be empty";
                                return null;
                              },
                              onSaved: (text) => controller.password = text,
                              onChanged: controller.saveLoginCredentials,
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
                          const SizedBox(height: 12.0),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            minLeadingWidth: 0,
                            horizontalTitleGap: 2,
                            leading: SizedBox(
                              width: 32,
                              child: Obx(
                                () => CheckboxListTile(
                                  value: controller.rememberMe.value,
                                  onChanged: (value) {
                                    controller.toggleRememberMe(value);
                                    TextInput.finishAutofillContext();
                                  },
                                ),
                              ),
                            ),
                            title: Text(
                              'Remember Me',
                              style: Get.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: GestureDetector(
                              child: Text(
                                'Forgot Password',
                                style:
                                    TextStyle(color: MyColors.greenAccentColor),
                              ),
                              onTap: () {
                                Get.toNamed(AppRoutes.forGetPasswordScreen);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: MyButton(
                              onTap: controller.buttonAction.value
                                  ? () {
                                      TextInput.finishAutofillContext();
                                      controller.login();
                                    }
                                  : null,
                              text: 'SIGN IN',
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.signUp_Screen);
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: Get.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.blueColor
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
            )
          ],
        ),
      ),
    );
  }
}
