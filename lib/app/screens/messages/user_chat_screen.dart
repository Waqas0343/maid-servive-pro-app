import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app_assets/app_styles/my_colors.dart';
import 'package:intl/intl.dart';

import 'controller/user_chat_screen_controller.dart';

class UserChatScreen extends StatelessWidget {
  const UserChatScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final ChatScreenController controller = Get.put(ChatScreenController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Implement more actions if needed
            },
          ),
        ],
      ),
      body: GetBuilder<ChatScreenController>(
        builder: (controller) {
          return Obx(
                () {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.chatMessages.length,
                        itemBuilder: (context, index) {
                          var message = controller.chatMessages[index];
                          bool isSender = message.senderId == controller.userId;
                          return ChatMessage(
                            isSender: isSender,
                            message: message.message,
                            time: DateFormat('hh:mm a').format(
                              message.createdAt,
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.grey[200],
                              ),
                              child: TextFormField(
                                controller: controller.messageController,
                                decoration: InputDecoration(
                                  hintText: "Type your message...",
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 14,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(24),
                            color: MyColors.primaryColor,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(24),
                              onTap: () {
                                controller.sendMessageUsingApi();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final bool isSender;
  final String message;
  final String time;

  const ChatMessage({
    Key? key,
    required this.isSender,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSender ? MyColors.primaryColor : Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: isSender ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    color: MyColors.shimmerBaseColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}