import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/screens/app_common_widget/custom_card.dart';
import '../../routes/app_routes.dart';
import '../app_common_widget/igp_list_shimmer.dart';
import 'controller/chat_user_controller.dart';
import 'package:intl/intl.dart';

import 'models/user_chats_model.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final MessageScreenController controller =
        Get.put(MessageScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
      ),
      body: Obx(
        () => Column(
          children: [
            if (controller.chatDataList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4,
                  ),
                  itemBuilder: (_, int index) {
                    final ChatDataModel chat = controller.chatDataList[index];
                    return CustomCard(
                      onPressed: () => Get.toNamed(AppRoutes.userChatScreen, arguments: chat),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: chat.userOne.image.toString().isEmpty
                              ? const Icon(Icons.person)
                              : null,
                          backgroundImage: chat.userOne.image.toString().isEmpty
                              ? null
                              : CachedNetworkImageProvider(
                                  chat.userOne.image.toString(),
                                ),
                        ),
                        title: Text(
                          chat.userTwo.fname + " " + chat.userTwo.lname,
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(chat.chats.isNotEmpty
                                ? chat.chats.last.message
                                : "No messages"),
                            Text("ID: ${chat.id}"),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(DateFormat('hh:mm a').format(chat.updatedAt),
                                style: TextStyle(fontSize: 12)),
                            Text(
                              DateFormat('yyyy-MM-dd').format(chat.updatedAt),
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: controller.chatDataList.length,
                ),
              ),
            if (controller.chatDataList.isEmpty && controller.isLoading.value)
              const Expanded(
                child: AllNotificationsShimmer(),
              ),
            if (!controller.isLoading.value && controller.chatDataList.isEmpty)
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
