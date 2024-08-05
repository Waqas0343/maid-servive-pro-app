import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_common_widget/my_button.dart';
import 'controllers/login_user_set_availability_controller.dart';

class SetLoginUserAvailabilityScreen extends StatelessWidget {
  const SetLoginUserAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginUserSetAvailabilityController controller = Get.put(LoginUserSetAvailabilityController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Availability'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Start Time:',
              style: Get.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: controller.selectedStartTime,
              onChanged: (value) {
                controller.selectStartTime(value!);
              },
              items: LoginUserSetAvailabilityController.hours
                  .map((hour) => DropdownMenuItem(
                child: Text(hour),
                value: hour,
              ))
                  .toList(),
            ),
            SizedBox(height: 10),
            Text(
              'Select End Time:',
              style: Get.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: controller.selectedEndTime,
              onChanged: (value) {
                controller.selectEndTime(value!);
              },
              items: LoginUserSetAvailabilityController.hours
                  .map((hour) => DropdownMenuItem(
                child: Text(hour),
                value: hour,
              ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Select Available Days:',
              style: Get.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            GetBuilder<LoginUserSetAvailabilityController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.days.map((day) {
                    return Row(
                      children: [
                        Checkbox(
                          value: controller.availabilityMap[
                          controller.dayIds[day]],
                          onChanged: (isChecked) {
                            controller.toggleDaySelection(day, isChecked!);
                          },
                        ),
                        Text(day),
                      ],
                    );
                  }).toList(),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: MyButton(
                onTap: () {
                  controller.saveUserAvailability();
                },
                text: 'Continue',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
