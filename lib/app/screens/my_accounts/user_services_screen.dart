import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import '../../../helpers/text_formatter.dart';
import '../app_common_widget/my_button.dart';
import 'controllers/user_services_controller.dart';
import 'models/currency_model.dart';
import 'models/languages_model.dart';
import 'models/user_services_model.dart';

class UserServicesScreen extends StatelessWidget {
  const UserServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserServicesController userServicesController =
        Get.put(UserServicesController());
    return Scaffold(
      appBar: AppBar(
        title: Text("User Services"),
      ),
      body: Form(
        key: userServicesController.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Obx(() {
              if (userServicesController.showButton.value.isNotEmpty) {
                return Visibility(
                  visible: userServicesController.showButton.value.isNotEmpty,
                  child: TypeAheadFormField<UserServicesSubDataListModel>(
                    direction: AxisDirection.down,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      enabled: userServicesController.selectedServicesTextController.text.isEmpty,
                      controller:
                      userServicesController.selectedServicesTextController,
                      decoration: const InputDecoration(
                        labelText: 'Services Name',
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return userServicesController.userServicesList
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
                    onSuggestionSelected: (UserServicesSubDataListModel selected) {
                      userServicesController.selectedServices.value = selected;
                      userServicesController.selectedServicesTextController.text =
                          selected.name;
                    },
                  ),
                );
              }
              return  TypeAheadFormField<UserServicesSubDataListModel>(
                direction: AxisDirection.down,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  controller:
                  userServicesController.selectedServicesTextController,
                  decoration: const InputDecoration(
                    labelText: 'Services Name',
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return userServicesController.userServicesList
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
                onSuggestionSelected: (UserServicesSubDataListModel selected) {
                  userServicesController.selectedServices.value = selected;
                  userServicesController.selectedServicesTextController.text =
                      selected.name;
                },
              );
            }),

            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: userServicesController.experienceTextController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Experience',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: userServicesController.educationTextController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Education (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (text) {
                if (text!.isEmpty) {
                  return "Education cannot be empty";
                } else if (!TextInputFormatterHelper.validText.hasMatch(text)) {
                  return "Education";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TypeAheadFormField<LanguagesDataListModel>(
              direction: AxisDirection.down,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: false,
                enabled: true,
                controller:
                    userServicesController.selectedLanguageTextController,
                decoration: const InputDecoration(
                  labelText: 'Language',
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              ),
              suggestionsCallback: (pattern) {
                return userServicesController.languageList
                    .where((servicesName) => servicesName.name
                        .toLowerCase()
                        .contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, LanguagesDataListModel suggestion) {
                return ListTile(
                  title: Text(suggestion.name),
                );
              },
              onSuggestionSelected: (LanguagesDataListModel selected) {
                userServicesController.selectedLanguage.value = selected;
                userServicesController.selectedLanguageTextController.text =
                    selected.name;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: userServicesController.aboutTextController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'About',
              ),
              validator: (text) {
                if (text!.isEmpty) {
                  return "About cannot be empty";
                } else if (!TextInputFormatterHelper.mixedPattern
                    .hasMatch(text)) {
                  return "About";
                }
                return null;
              },
              maxLines: 3,
            ),
            SizedBox(height: 10),
            TypeAheadFormField<GetCurrencyDataListModel>(
              direction: AxisDirection.down,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: false,
                enabled: true,
                controller: userServicesController.selectedServicesCurrency,
                decoration: const InputDecoration(
                  labelText: 'Select Currency',
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              ),
              suggestionsCallback: (pattern) {
                return userServicesController.currencyList
                    .where((servicesName) => servicesName.name
                        .toLowerCase()
                        .contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, GetCurrencyDataListModel suggestion) {
                return ListTile(
                  title: Text(suggestion.name),
                );
              },
              onSuggestionSelected: (GetCurrencyDataListModel selected) {
                userServicesController.selectedCurrency.value = selected;
                userServicesController.selectedServicesCurrency.text =
                    selected.name;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: userServicesController.priceTextController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Price Per Hour',
              ),
              validator: (text) {
                if (text!.isEmpty) {
                  return "Price Per Hour cannot be empty";
                } else if (!TextInputFormatterHelper.validNumber
                    .hasMatch(text)) {
                  return "Price Per Hour";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Obx(() {
                final userServicesList =
                    userServicesController.userServicesInformationList;
                if (userServicesList.isEmpty) {
                  return MyButton(
                    text: 'Add',
                    onTap: () async {
                      userServicesController.addServices();
                    },
                  );
                } else {
                  return MyButton(
                    text: userServicesList[0].serviceproviderServices.isEmpty
                        ? 'Add'
                        : 'Update',
                    onTap: () async {
                      userServicesController.addServices();
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
