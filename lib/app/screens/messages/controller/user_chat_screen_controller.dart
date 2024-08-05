import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/helpers/server/api_fetch.dart';
import 'package:go_maids_pro/helpers/connectivity.dart';
import 'package:intl/intl.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../services/preferences.dart';
import '../models/single_chat_model.dart';
import '../models/user_chats_model.dart';

class ChatScreenController extends GetxController {
  final RxList<ChatDataModel> chatDataList = RxList<ChatDataModel>();
  final RxList<ChatMessage> chatMessages = RxList<ChatMessage>();
  final TextEditingController messageController = TextEditingController();
  final int userId = Get.find<Preferences>().getInt(Keys.userId) ?? 0;
  String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
  final RxBool isLoading = true.obs;
   RxInt singleChatID = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments is ChatDataModel) {
      final chatData = arguments;
      singleChatID.value = chatData.id;
      getChatMessages(chatData.id);
      startPusherSocket();
    } else {
      Get.back();
    }
  }

  void getChatMessages(int userId) async {
    isLoading.value = true;
    chatMessages.clear();
    final messages = await ApiFetch.getChatAgainstSingleUser(userId);
    if (messages != null) {
      chatMessages.assignAll(messages);
      update();
    }
    isLoading.value = false;
  }


  void startPusherSocket() async {
    await initiatePusherSocketForMessaging();
  }

  Future<void> initiatePusherSocketForMessaging() async {
    // Get an instance of the PusherChannelsFlutter client
    PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

    try {
      await pusher.init(
        apiKey: '4b70cc9598b80dcadac2',
        cluster: 'ap2',
        authEndpoint: 'https://maid-service.tecrux.solutions/public/api/broadcasting/auth?host=https://maid-service.tecrux.solutions&Authorization=Bearer $token',
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
      );

      // Subscribe to a private channel specific to the user ID
      await pusher.subscribe(channelName: 'private-message_$userId');

      // Connect to the Pusher service
      await pusher.connect();
    } catch (e) {
      // Handle any errors that occur during initialization
      print("ERROR: $e");
    }
  }



  // Event handlers
  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    print("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    print("onMemberAdded: $channelName member: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    print("onMemberRemoved: $channelName member: $member");
  }

  void onEvent(PusherEvent event) {
    print("onEvent: $event");
    final data = event.data;
    // Handle incoming message event
    // Assuming event data contains the necessary properties for ChatMessage
    ChatMessage newMessage = ChatMessage(
      id: data['id'],
      message: data['message'],
      receiverId: data['receiverId'],
      senderId: data['senderId'],
      orderId: data['orderId'],
      image: data['image'],
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      conversationId: data['conversationId'],
      status: data['status'],
      isSeen: data['isSeen'],
      receiverUser: data['receiverUser'],
      senderUser: data['senderUser'],
      conversation: data['conversation'],
    );
    // Add the new message to the beginning of the chatMessages list
    chatMessages.insert(0, newMessage);
  }
  void sendMessage() async {
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      return;
    }

    // Extract the message from the text field
    String message = messageController.text.trim();

    // Check if the message is empty
    if (message.isEmpty) {
      print('Message cannot be empty');
      return;
    }

    // Initialize PusherChannelsFlutter instance
    PusherChannelsFlutter pusher = PusherChannelsFlutter();

    // Trigger the event to send the message via Pusher Channels
    try {
      await pusher.trigger(
        PusherEvent(
          channelName: 'private-message_$userId', // Channel name
          eventName: 'new_message', // Event name
          data: {'message': message}, // Event data
        ),
      );
      print('Message sent successfully via Pusher Channels');
    } catch (e) {
      print('Error sending message via Pusher Channels: $e');
    }

    // Clear the message input field after sending the message
    messageController.clear();
  }




  void sendMessageUsingApi() async {
    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      return;
    }

    if (chatMessages.isNotEmpty) {
      final firstMessage = chatMessages.first;
      final conversationId = firstMessage.conversationId;
      final receiverId = firstMessage.receiverId;

      Map<String, dynamic> data = {
        'conversation_id': conversationId,
        'message': messageController.text,
        'reciever_id': receiverId,
      };

      var response = await ApiFetch.addNewChatMessage(data);
      if (response != null && response['success'] == true) {
        print('Message sent successfully');
        messageController.clear();
         getChatMessages(singleChatID.value);
      }
    } else {
      print('No chat messages available');
    }
  }





  String getLocalTime({required String hour, required String minute}) {
    return Keys.getFormattedTime(
        time: DateFormat('HH:mm:ss')
            .parse(Keys.getFormattedTime2(time: '$hour:$minute'), true)
            .toLocal()
            .toString()
            .split(' ')[1]);
  }
}

class MyDateTime {
  final MyDateModel? myDateModel;
  final MyTimeModel? myTimeModel;

  MyDateTime({this.myDateModel, this.myTimeModel});
}

class MyDateModel {
  final String day;
  final String month;
  final String year;

  MyDateModel({required this.day, required this.month, required this.year});
}

class MyTimeModel {
  final String hour;
  final String minute;
  final String meridian;

  MyTimeModel(
      {required this.hour, required this.minute, required this.meridian});
}

class SendChatMessage {
  final int id;
  final String message;
  final int senderId;
  final int receiverId;
  final String? image;
  final DateTime createdAt;
  final int conversationId;
  final int status;
  final int isSeen;

  SendChatMessage({
    required this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.image,
    required this.createdAt,
    required this.conversationId,
    required this.status,
    required this.isSeen,
  });
}

class SendMessageModel {
  final int messageId;
  final String message;
  final int senderId;
  final int receiverId;
  final String image;
  final MyDateTime myDateTime;
  final bool isTimeFromServer;

  SendMessageModel({
    required this.messageId,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.image,
    required this.myDateTime,
    required this.isTimeFromServer,
  });

  factory SendMessageModel.fromChatMessage(ChatMessage chatMessage) {
    return SendMessageModel(
      messageId: chatMessage.id,
      message: chatMessage.message,
      senderId: chatMessage.senderId,
      receiverId: chatMessage.receiverId,
      image: chatMessage.image ?? "",
      // Assuming image can be nullable in ChatMessage
      myDateTime: MyDateTime(
        // You need to map DateTime to MyDateTime if required
        myDateModel: MyDateModel(
          day: chatMessage.createdAt.day.toString(),
          month: chatMessage.createdAt.month.toString(),
          year: chatMessage.createdAt.year.toString(),
        ),
        myTimeModel: MyTimeModel(
          hour: chatMessage.createdAt.hour.toString(),
          minute: chatMessage.createdAt.minute.toString(),
          meridian: chatMessage.createdAt.hour < 12 ? 'AM' : 'PM',
        ),
      ),
      isTimeFromServer: false,
    );
  }
}