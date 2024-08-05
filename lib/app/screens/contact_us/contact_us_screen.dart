import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import '../../../helpers/text_formatter.dart';
import '../app_common_widget/my_button.dart';
import '../my_accounts/models/user_services_model.dart';
import 'contact_us_controller.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key});
  @override
  Widget build(BuildContext context) {
    final ContactUsController controller = Get.put(ContactUsController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              "We are here for you",
              style: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Contact Information",
              style: Get.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.phone, color: MyColors.primaryColor),
              title: Text("Phone"),
              subtitle: Text(
                "+1 (236) 808-6010",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Divider(
              thickness: 1,
              color: MyColors.primaryColor,
            ),
            ListTile(
              leading: Icon(Icons.email, color: MyColors.primaryColor),
              title: Text("Email"),
              subtitle: Text(
                "info@gomaidz.com",
                style: TextStyle(color: Colors.black87),
              ),
            ), Divider(
              thickness: 1,
              color: MyColors.primaryColor,
            ),

            ListTile(
              leading: Icon(Icons.location_on, color: MyColors.primaryColor),
              title: Text("Location"),
              subtitle: Text(
                "127 Westmore, Dr, Unit 119, Etobicoke, ON M9V 3Y6, Canada",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Divider(
              thickness: 1,
              color: MyColors.primaryColor,
            ),
            SizedBox(height: 20),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: controller.fullNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Full Name cannot be empty";
                      } else if (!TextInputFormatterHelper.validText
                          .hasMatch(text)) {
                        return "Full Name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Your Email cannot be empty";
                      } else if (!TextInputFormatterHelper.validEmail
                          .hasMatch(text)) {
                        return "Your Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: controller.phoneNoController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Your Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Phone Number cannot be empty";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10),
                  TypeAheadFormField<UserServicesSubDataListModel>(
                    direction: AxisDirection.down,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      enabled: true,
                      controller: controller.selectedServicesTextController,
                      decoration: const InputDecoration(
                        labelText: 'Services Name',
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return controller.userServicesList
                          .where((servicesName) => servicesName.name
                          .toLowerCase()
                          .contains(pattern.toLowerCase()))
                          .toList();
                    },
                    itemBuilder: (context, UserServicesSubDataListModel suggestion) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(suggestion.image),
                        ),
                        title: Text(suggestion.name),
                      );
                    },
                    onSuggestionSelected: (UserServicesSubDataListModel selected) {
                      controller.selectedServices.value = selected;
                      controller.selectedServicesTextController.text =
                          selected.name;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: controller.messageController,
                    textInputAction: TextInputAction.next,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Your Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Message cannot be empty";
                      } else if (!TextInputFormatterHelper.numberAndText
                          .hasMatch(text)) {
                        return "Message";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),

            MyButton(
              text: 'Submit',
              onTap: () async {
                controller.savaUserContactUsData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
