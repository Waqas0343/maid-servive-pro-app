import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import '../app_common_widget/my_button.dart';
import 'email_verify_controller.dart';

class EmailVerify extends StatelessWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EmailVerifyController controller = Get.put(EmailVerifyController());
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () => Get.offAllNamed('/welcome_screen'),
                              child: const Icon(
                                Icons.arrow_back,
                                size: 24,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            'Registration',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      width: w,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 225, 245),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Image.asset(
                          'assets/images/email.png',
                          height: 120,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    const Text(
                      'Email Verification',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "We will send you a One Time Password on this Email",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Obx(() => TextFormField(
                                readOnly: true,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  labelStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: controller.email.value,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 22,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.sendEmailOtp();
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  MyColors.accentColor,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      24.0,
                                    ),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child:
                                    Obx(() => controller.otpSendingLoading.value
                                        ? const Text('Sending...')
                                        : const Text(
                                            'Send',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          )),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (controller.showDialog.value) {
                  return Center(
                    child: GestureDetector(
                      onTap: () => controller.showDialog.value = false,
                      child: Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 7.0,
                                  top: 7,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                        controller.pinController.clear();
                                        controller.otpSendingLoading.value =
                                            false;
                                      },
                                      child: Container(
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Verification Code',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Text(
                                  'Please enter the OTP',
                                  style: GoogleFonts.actor(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OtpTextField(
                                  numberOfFields: 4,
                                  borderColor: controller.isValid.value ? Colors.black12 : Colors.red,
                                  focusedBorderColor: Colors.black12,
                                  showFieldAsBox: true,
                                  onCodeChanged: (String code) {
                                    controller.isValid.value = controller.validateCode(code);
                                  },
                                  onSubmit: (String code) {
                                    controller.verificationCode.value = code;
                                    controller.verifyEmailCodeEmailCode(code);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: h * 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Obx(
                                      () => MyButton(
                                    onTap: () {
                                      if (controller.verificationCode.value.isNotEmpty) {
                                        controller.verifyEmailCodeEmailCode(controller.verificationCode.value);
                                      }
                                    },
                                    text: controller.otpSendingLoading.value ? 'Loading...' : 'Validate',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 4,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              })
            ],
          ),
        ),
      ),
    );
  }
}
