import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/routes/app_routes.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import '../app_common_widget/custom_card.dart';
import '../app_common_widget/igp_list_shimmer.dart';
import 'notification_model.dart';
import 'notification_screen_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationScreenController controller =
        Get.put(NotificationScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Obx(
        () => Column(
          children: [
            if (controller.userNotificationDataList.isNotEmpty)
              Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4,
                ),
                itemBuilder: (_, int index) {
                  NotificationDataListModel notificationModel = controller.userNotificationDataList[index];
                  Color backgroundColor = index % 2 == 0
                      ? Colors.white
                      : const Color(0xffe5f7f1,);
                  return CustomCard(
                    onPressed: () {
                      if (notificationModel.title == 'Order Recieved') {
                        Get.toNamed(AppRoutes.myOrderScreen);
                      } else if (notificationModel.title == 'Complete the Profile') {
                        Get.toNamed(AppRoutes.userProfileScreen);
                      } else {
                        controller.readNotification(controller.userID!, notificationModel);
                      }
                    },
                    color: backgroundColor,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 20.0,
                        backgroundColor: MyColors.primaryColor,
                        child: Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notificationModel.title.toString(),
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            notificationModel.description,
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        controller.dateFormat.format(DateTime.parse(notificationModel.createdAt.toString())),
                      ),
                      trailing: Obx(() {
                        return Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: notificationModel.isRead.value
                                ? Colors.transparent
                                : Colors.red,
                          ),
                        );
                      }),
                    ),
                  );
                },
                itemCount: controller.userNotificationDataList.length,
              )),
            if (controller.userNotificationDataList.isEmpty &&
                controller.isLoading.value)
              const Expanded(
                child: AllNotificationsShimmer(),
              ),
            if (!controller.isLoading.value &&
                controller.userNotificationDataList.isEmpty)
              const Expanded(
                child: Center(
                  child: Text("No Data Found..."),
                ),
              )
          ],
        ),
      ),
    );
  }
}
