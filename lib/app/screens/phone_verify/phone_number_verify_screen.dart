import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/screens/phone_verify/phone_number_verify_controller.dart';
import 'package:go_maids_pro/app_assets/app_styles/my_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_common_widget/my_button.dart';

class PhoneVerify extends StatelessWidget {
  const PhoneVerify({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PhoneVerifyController controller = Get.put(PhoneVerifyController());
    double h = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 29,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 231, 235, 246),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/illustration-2.png',
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'Verify your Mobile Number',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Add your phone number. we'll send you a verification code so we know you're real",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Form(
                              child: SizedBox(
                                height: 50,
                                child: TextFormField(
                                  controller: controller.phoneController,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a phone number';
                                    }
                                    // You can add more complex validation here if needed
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Phone number',
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    labelStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    hintText: '1234567890',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(left: 0.0, right: 8.0), // Adjust padding as needed
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black12), // Customize border color
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: CountryCodePicker(
                                          onChanged: (country) {
                                            controller.selectedCountryCode.value = country.dialCode!;
                                          },
                                          initialSelection: 'US',
                                          favorite: const ['US', 'CA'],
                                          showFlag: false,
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          dialogTextStyle: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ),
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.sendCodeToMobile(controller.phoneController.text, controller.email.value);
                                },
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(
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
                                      ? const Text('Loading...')
                                      : const Text(
                                    'Send',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  if(controller.showDialog.value){

                    return  Center(
                      child: GestureDetector(
                        onTap: () => controller.showDialog.value = false,
                        child: Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                          controller.otpSendingLoading.value = false;
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
                                      controller.verifyPhoneCode(code);
                                    },
                                  ),
                                ),

                                SizedBox(
                                  height: h * 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Obx(
                                        () => MyButton(
                                      onTap: () {
                                        if (controller.verificationCode.value.isNotEmpty) {
                                          controller.verifyPhoneCode(controller.verificationCode.value);
                                        }
                                      },
                                      text: controller.otpSendingLoading.value
                                          ? 'Loading...'
                                          : 'Validate',
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
                }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}