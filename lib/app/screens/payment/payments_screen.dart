import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/screens/payment/payment_screen_controller.dart';

import '../../../helpers/text_formatter.dart';
import '../app_common_widget/my_button.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentScreenController controller = Get.put(PaymentScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => ListView(
            children: [
              Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => RadioListTile<PaymentMethod>(
                        title: Text('Stripe'),
                        value: PaymentMethod.Stripe,
                        groupValue: controller.selectedMethod.value,
                        onChanged: (value) =>
                            controller.selectedMethod.value = value!,
                      )),
                  Obx(() => RadioListTile<PaymentMethod>(
                        title: Text('Paypal'),
                        value: PaymentMethod.Paypal,
                        groupValue: controller.selectedMethod.value,
                        onChanged: (value) =>
                            controller.selectedMethod.value = value!,
                      )),
                  Obx(() => RadioListTile<PaymentMethod>(
                        title: Text('Bank'),
                        value: PaymentMethod.Bank,
                        groupValue: controller.selectedMethod.value,
                        onChanged: (value) =>
                            controller.selectedMethod.value = value!,
                      )),
                ],
              ),
              SizedBox(height: 20),
              controller.selectedMethod.value == PaymentMethod.Stripe
                  ? Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Stripe Keys',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: controller.stripeClientIDController,
                            decoration: InputDecoration(
                              labelText: 'Stripe Client ID',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Stripe Client ID' cannot be empty";
                              } else if (!TextInputFormatterHelper.mixedPattern
                                  .hasMatch(text)) {
                                return "Stripe Client ID";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: controller.stripeSecretKeyController,
                            decoration: InputDecoration(
                              labelText: 'Stripe Secret Key',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Stripe Secret Key cannot be empty";
                              } else if (!TextInputFormatterHelper.mixedPattern
                                  .hasMatch(text)) {
                                return "Stripe Secret Key";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              controller.selectedMethod.value == PaymentMethod.Paypal
                  ? Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Paypal Keys',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: controller.paypalClientIDController,
                            decoration: InputDecoration(
                              labelText: 'Paypal Client ID',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Paypal Client ID cannot be empty";
                              } else if (!TextInputFormatterHelper.mixedPattern
                                  .hasMatch(text)) {
                                return "Paypal Client ID";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: controller.paypalSecretKeyController,
                            decoration: InputDecoration(
                              labelText: 'Paypal Secret Key',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Paypal Secret Key cannot be empty";
                              } else if (!TextInputFormatterHelper.mixedPattern
                                  .hasMatch(text)) {
                                return "Paypal Secret Key";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              controller.selectedMethod.value == PaymentMethod.Bank
                  ? Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Bank Details',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: controller.accountNumberController,
                            decoration: InputDecoration(
                              labelText: 'Account Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Account Number cannot be empty";
                              } else if (!TextInputFormatterHelper.mixedPattern
                                  .hasMatch(text)) {
                                return "Account Number";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          DropdownButtonFormField(
                            value: controller.selectedBankType.value,
                            onChanged: (String? newValue) {
                              controller.selectedBankType.value = newValue!;
                            },
                            hint: const Text("Bank Type"),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor:
                              Colors.white, // Set the background color here
                            ),
                            items: controller.lineSectionName
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: controller.firstNameController,
                            decoration: InputDecoration(
                              labelText: 'Account Holder First Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "First Name cannot be empty";
                              } else if (!TextInputFormatterHelper.validText
                                  .hasMatch(text)) {
                                return "First Name";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: controller.lastNameController,
                            decoration: InputDecoration(
                              labelText: 'Account Holder Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Last Name cannot be empty";
                              } else if (!TextInputFormatterHelper.validText
                                  .hasMatch(text)) {
                                return "BLast Name";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),

                          TextFormField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              labelText: 'Account Holder Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Email cannot be empty";
                              } else if (!TextInputFormatterHelper.validEmail
                                  .hasMatch(text)) {
                                return "Email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: controller.phoneController,
                            decoration: InputDecoration(
                              hintText: '+13367802671',
                              labelText: 'Account Holder Phone Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Phone Number cannot be empty";
                              } else if (!TextInputFormatterHelper.mixedPattern
                                  .hasMatch(text)) {
                                return "Phone Number";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () async {
                              await controller.pickFromDate();
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: controller.dobController,
                                keyboardType: TextInputType.datetime,
                                decoration: const InputDecoration(
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
                          SizedBox(height: 10),
                          TextFormField(
                            controller: controller.countryController,
                            decoration: InputDecoration(
                              labelText: 'Country',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Bank Country cannot be empty";
                              } else if (!TextInputFormatterHelper.validText
                                  .hasMatch(text)) {
                                return "Bank Country";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: controller.stateController,
                            decoration: InputDecoration(
                              labelText: 'State',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "State cannot be empty";
                              } else if (!TextInputFormatterHelper.validText
                                  .hasMatch(text)) {
                                return "State";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: controller.cityController,
                            decoration: InputDecoration(
                              labelText: 'City',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "City cannot be empty";
                              } else if (!TextInputFormatterHelper.validText
                                  .hasMatch(text)) {
                                return "City Name";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: controller.postalCodeController,
                            decoration: InputDecoration(
                              labelText: 'Postal Code',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Postal Code cannot be empty";
                              } else if (!TextInputFormatterHelper.mixedPattern
                                  .hasMatch(text)) {
                                return "Postal Code";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: controller.addressController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Bank Address cannot be empty";
                              } else if (!TextInputFormatterHelper.mixedPattern
                                  .hasMatch(text)) {
                                return "Bank Address";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Flexible(
              child: MyButton(
                text: 'Save',
                onTap: () async {
                  if (controller.selectedMethod.value == PaymentMethod.Stripe) {
                    controller.addStripePaymentMethod();
                  } else if (controller.selectedMethod.value ==
                      PaymentMethod.Paypal) {
                    controller.addPaypalPaymentMethod();
                  } else {
                    controller.addBankPaymentMethod();
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
