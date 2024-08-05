import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import '../../../helpers/text_formatter.dart';
import '../app_common_widget/my_button.dart';
import 'controllers/add_new_dispute_controller.dart';
import 'models/get_user_dispute_model.dart';

class AddNewDisputeScreen extends StatelessWidget {
  const AddNewDisputeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddNewDisputeController controller = Get.put(AddNewDisputeController());
    return Scaffold(
      appBar:AppBar(
        title: Text("Add New Dispute"),
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              controller: controller.userNameController,
              textInputAction: TextInputAction.next,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                labelText: 'User Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TypeAheadFormField<Order>(
              direction: AxisDirection.down,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: false,
                enabled: true,
                controller: controller.selectedOrderTextController,
                decoration: const InputDecoration(
                  labelText: 'Order Key',
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              ),
              suggestionsCallback: (pattern) {
                return controller.orderList
                    .where((order) => order.orderKey
                    .toLowerCase()
                    .contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, Order suggestion) {
                return ListTile(
                  title: Text(suggestion.orderKey),
                  subtitle: Text('Order ID: ${suggestion.id}'),
                );
              },
              onSuggestionSelected: (Order selected) {
                controller.selected = selected;
                controller.selectedOrderTextController.text =
                    selected.orderKey;
              },
            ),

            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: controller.titleController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: controller.descriptionController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Description',
              ),
              validator: (text) {
                if (text!.isEmpty) {
                  return "Price Per Hour cannot be empty";
                } else if (!TextInputFormatterHelper.validText
                    .hasMatch(text)) {
                  return "Description";
                }
                return null;
              },
              maxLines: 3,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Row(
                children: [
                  Flexible(
                    child: MyButton(
                      text: 'Submit',
                      onTap: () async {
                        controller.addNewDispute();
                      },
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
