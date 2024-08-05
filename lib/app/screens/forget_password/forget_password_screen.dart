import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/text_formatter.dart';
import '../app_common_widget/my_button.dart';
import 'forget_password_controller.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ForgetPassController controller = Get.put(ForgetPassController());
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 200, // Set the height of the image
                  width: 200, // Set the width of the image
                  child: Image.asset(
                    'assets/images/gomaids.png',
                    fit: BoxFit.contain,
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: MyButton(
                    onTap: controller.resetPassword,
                    text: 'Reset',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
