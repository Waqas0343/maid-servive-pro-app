class ChatMessage {
  final int id;
  final String message;
  final int receiverId;
  final int senderId;
  final int orderId;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int conversationId;
  final int status;
  final int isSeen;
  final ChatUser receiverUser;
  final ChatUser senderUser;
  final ChatConversation conversation;

  ChatMessage({
    required this.id,
    required this.message,
    required this.receiverId,
    required this.senderId,
    required this.orderId,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.conversationId,
    required this.status,
    required this.isSeen,
    required this.receiverUser,
    required this.senderUser,
    required this.conversation,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      message: json['message'],
      receiverId: int.parse(json['reciever_id']),
      senderId: int.parse(json['sender_id']),
      orderId: int.parse(json['order_id']),
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      conversationId: int.parse(json['conversation_id']),
      status: int.parse(json['status']),
      isSeen: int.parse(json['is_seen']),
      receiverUser: ChatUser.fromJson(json['reciever_user']),
      senderUser: ChatUser.fromJson(json['sender_user']),
      conversation: ChatConversation.fromJson(json['conversation']),
    );
  }
}

class ChatUser {
  final int id;
  final String username;
  final String image;

  ChatUser({
    required this.id,
    required this.username,
    required this.image,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json['id'],
      username: json['username'],
      image: json['image'],
    );
  }
}

class ChatConversation {
  final int id;
  final int userOne;
  final int userTwo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int status;
  final int orderId;
  final ChatOrder order;

  ChatConversation({
    required this.id,
    required this.userOne,
    required this.userTwo,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.orderId,
    required this.order,
  });

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    return ChatConversation(
      id: json['id'],
      userOne: int.parse(json['user_one']),
      userTwo: int.parse(json['user_two']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      status: int.parse(json['status']),
      orderId: int.parse(json['order_id']),
      order: ChatOrder.fromJson(json['order']),
    );
  }
}

class ChatOrder {
  final int id;
  final int serviceTakerId;
  final int serviceProviderId;
  final String orderKey;
  final String serviceAddress;
  final String billingAddress;
  final String slotStartTime;
  final String slotEndTime;
  final String orderDate;
  final String cost;
  final String appCommission;
  final String status;
  final String country;
  final String state;
  final String city;
  final String selectedService;

  ChatOrder({
    required this.id,
    required this.serviceTakerId,
    required this.serviceProviderId,
    required this.orderKey,
    required this.serviceAddress,
    required this.billingAddress,
    required this.slotStartTime,
    required this.slotEndTime,
    required this.orderDate,
    required this.cost,
    required this.appCommission,
    required this.status,
    required this.country,
    required this.state,
    required this.city,
    required this.selectedService,
  });

  factory ChatOrder.fromJson(Map<String, dynamic> json) {
    return ChatOrder(
      id: json['id'],
      serviceTakerId: int.parse(json['service_taker_id']),
      serviceProviderId: int.parse(json['service_provider_id']),
      orderKey: json['order_key'],
      serviceAddress: json['service_address'],
      billingAddress: json['billing_address'],
      slotStartTime: json['slot_start_time'],
      slotEndTime: json['slot_end_time'],
      orderDate: json['order_date'],
      cost: json['cost'],
      appCommission: json['app_commission'],
      status: json['status'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      selectedService: json['selected_service'],
    );
  }
}
