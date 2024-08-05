import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/routes/app_routes.dart';
import '../app_common_widget/my_button.dart';
import '../my_accounts/models/currency_model.dart';
import '../my_accounts/models/languages_model.dart';
import '../my_accounts/models/user_services_model.dart';
import 'controllers/login_user_personal_detail_screen_controller.dart';

class LoginUserPersonalDetailsScreen extends StatelessWidget {
  const LoginUserPersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginUserPersonalDetailsController controller = Get.put(LoginUserPersonalDetailsController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: controller.formValidationKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 12.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    TypeAheadFormField<UserServicesSubDataListModel>(
                      direction: AxisDirection.down,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        enabled: true,
                        controller: controller.selectedServicesTextController,
                        decoration: const InputDecoration(
                          labelText: 'Select Service',
                          suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      validator: (text) {
                        if (text!.isEmpty) return "Can't be empty";
                        return null;
                      },
                      suggestionsCallback: (pattern) {
                        return controller.userServicesList
                            .where((servicesName) => servicesName.name
                                .toLowerCase()
                                .contains(pattern.toLowerCase()))
                            .toList();
                      },
                      itemBuilder:
                          (context, UserServicesSubDataListModel suggestion) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(suggestion.image),
                          ),
                          title: Text(suggestion.name),
                        );
                      },
                      onSuggestionSelected:
                          (UserServicesSubDataListModel selected) {
                        controller.selectedServices.value = selected;
                        controller.selectedServicesTextController.text =
                            selected.name;
                      },
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: controller.priceController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'price *',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) return "Can't be empty";
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          flex: 1,
                          child: Obx(
                            () => DropdownButtonFormField<
                                GetCurrencyDataListModel>(
                              value: controller.selectedCurrency.value,
                              items: controller.currencyList.map((department) {
                                return DropdownMenuItem<
                                    GetCurrencyDataListModel>(
                                  value: department,
                                  child: Text(department.name),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                controller.selectedCurrency.value = newValue;
                              },
                              decoration: InputDecoration(
                                hintText: 'Currency',
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ), // Hint text added here
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Add currency'; // Validation message
                                }
                                return null; // Return null if validation passes
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.experienceController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'experience *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (text) {
                        if (text!.isEmpty) return "Can't be empty";
                        return null;
                      },
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.educationController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'education *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (text) {
                        if (text!.isEmpty) return "Can't be empty";
                        return null;
                      },
                    ),
                    SizedBox(height: 12.0),
                    TypeAheadFormField<LanguagesDataListModel>(
                      direction: AxisDirection.down,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        enabled: true,
                        controller: controller.selectedLanguageTextController,
                        decoration: const InputDecoration(
                          labelText: 'Language',
                          suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      validator: (text) {
                        if (text!.isEmpty) return "Can't be empty";
                        return null;
                      },
                      suggestionsCallback: (pattern) {
                        return controller.languageList
                            .where((servicesName) => servicesName.name
                                .toLowerCase()
                                .contains(pattern.toLowerCase()))
                            .toList();
                      },
                      itemBuilder:
                          (context, LanguagesDataListModel suggestion) {
                        return ListTile(
                          title: Text(suggestion.name),
                        );
                      },
                      onSuggestionSelected: (LanguagesDataListModel selected) {
                        controller.selectedLanguage.value = selected;
                        controller.selectedLanguageTextController.text =
                            selected.name;
                      },
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Description',
                      style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.descriptionController,
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          'Auto Accept My Request',
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Obx(
                          () => Switch(
                            value: controller.autoAcceptRequest.value,
                            onChanged: (value) =>
                                controller.toggleAutoAcceptRequest(value),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: MyButton(
                            onTap: () {
                              Get.toNamed(AppRoutes.loginUserProfileDetail);
                            },
                            text: 'Back',
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: MyButton(
                            onTap: () {
                              controller.saveProfile();
                            },
                            text: 'Save and Continue',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
