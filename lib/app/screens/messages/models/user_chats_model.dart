class ChatModel {
  bool success;
  List<ChatDataModel> data;
  String message;

  ChatModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    success: json["success"],
    data: List<ChatDataModel>.from(json["data"].map((x) => ChatDataModel.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class ChatDataModel {
  int id;
  ChatUsersModel userOne;
  ChatUsersModel userTwo;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  String orderId;
  UserChatOrderModel order;
  List<UserChatListModel> chats;

  ChatDataModel({
    required this.id,
    required this.userOne,
    required this.userTwo,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.orderId,
    required this.order,
    required this.chats,
  });

  factory ChatDataModel.fromJson(Map<String, dynamic> json) => ChatDataModel(
    id: json["id"],
    userOne: ChatUsersModel.fromJson(json["user_one"]),
    userTwo: ChatUsersModel.fromJson(json["user_two"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    status: json["status"],
    orderId: json["order_id"],
    order: UserChatOrderModel.fromJson(json["order"]),
    chats: List<UserChatListModel>.from(json["chats"].map((x) => UserChatListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_one": userOne.toJson(),
    "user_two": userTwo.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "status": status,
    "order_id": orderId,
    "order": order.toJson(),
    "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
  };
}

class UserChatListModel {
  int id;
  String message;
  String recieverId;
  String senderId;
  String orderId;
  dynamic image;
  DateTime createdAt;
  DateTime updatedAt;
  String conversationId;
  String status;
  String isSeen;

  UserChatListModel({
    required this.id,
    required this.message,
    required this.recieverId,
    required this.senderId,
    required this.orderId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.conversationId,
    required this.status,
    required this.isSeen,
  });

  factory UserChatListModel.fromJson(Map<String, dynamic> json) => UserChatListModel(
    id: json["id"],
    message: json["message"],
    recieverId: json["reciever_id"],
    senderId: json["sender_id"],
    orderId: json["order_id"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    conversationId: json["conversation_id"],
    status: json["status"],
    isSeen: json["is_seen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "reciever_id": recieverId,
    "sender_id": senderId,
    "order_id": orderId,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "conversation_id": conversationId,
    "status": status,
    "is_seen": isSeen,
  };
}

class UserChatOrderModel {
  int id;
  String serviceTakerId;
  String serviceProviderId;
  String orderKey;
  dynamic requestAccepted;
  String serviceAddress;
  String billingAddress;
  dynamic lat;
  dynamic lng;
  String slotStartTime;
  String slotEndTime;
  DateTime orderDate;
  String cost;
  String appCommission;
  dynamic serviceTakerFeedback;
  dynamic serviceProviderFeedback;
  String additionalNotes;
  String status;
  String stStatus;
  String spStatus;
  dynamic rating;
  String country;
  String state;
  String city;
  DateTime createdAt;
  DateTime updatedAt;
  String selectedService;
  dynamic spRating;
  dynamic tipamount;
  dynamic perHourRate;
  String paymentStatus;
  String commissionType;

  UserChatOrderModel({
    required this.id,
    required this.serviceTakerId,
    required this.serviceProviderId,
    required this.orderKey,
    required this.requestAccepted,
    required this.serviceAddress,
    required this.billingAddress,
    required this.lat,
    required this.lng,
    required this.slotStartTime,
    required this.slotEndTime,
    required this.orderDate,
    required this.cost,
    required this.appCommission,
    required this.serviceTakerFeedback,
    required this.serviceProviderFeedback,
    required this.additionalNotes,
    required this.status,
    required this.stStatus,
    required this.spStatus,
    required this.rating,
    required this.country,
    required this.state,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    required this.selectedService,
    required this.spRating,
    required this.tipamount,
    required this.perHourRate,
    required this.paymentStatus,
    required this.commissionType,
  });

  factory UserChatOrderModel.fromJson(Map<String, dynamic> json) => UserChatOrderModel(
    id: json["id"],
    serviceTakerId: json["service_taker_id"],
    serviceProviderId: json["service_provider_id"],
    orderKey: json["order_key"],
    requestAccepted: json["request_accepted"],
    serviceAddress: json["service_address"],
    billingAddress: json["billing_address"],
    lat: json["lat"],
    lng: json["lng"],
    slotStartTime: json["slot_start_time"],
    slotEndTime: json["slot_end_time"],
    orderDate: DateTime.parse(json["order_date"]),
    cost: json["cost"],
    appCommission: json["app_commission"],
    serviceTakerFeedback: json["service_taker_feedback"],
    serviceProviderFeedback: json["service_provider_feedback"],
    additionalNotes: json["additional_notes"],
    status: json["status"],
    stStatus: json["st_status"],
    spStatus: json["sp_status"],
    rating: json["rating"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    selectedService: json["selected_service"],
    spRating: json["sp_rating"],
    tipamount: json["tipamount"],
    perHourRate: json["per_hour_rate"],
    paymentStatus: json["payment_status"],
    commissionType: json["commission_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_taker_id": serviceTakerId,
    "service_provider_id": serviceProviderId,
    "order_key": orderKey,
    "request_accepted": requestAccepted,
    "service_address": serviceAddress,
    "billing_address": billingAddress,
    "lat": lat,
    "lng": lng,
    "slot_start_time": slotStartTime,
    "slot_end_time": slotEndTime,
    "order_date": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
    "cost": cost,
    "app_commission": appCommission,
    "service_taker_feedback": serviceTakerFeedback,
    "service_provider_feedback": serviceProviderFeedback,
    "additional_notes": additionalNotes,
    "status": status,
    "st_status": stStatus,
    "sp_status": spStatus,
    "rating": rating,
    "country": country,
    "state": state,
    "city": city,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "selected_service": selectedService,
    "sp_rating": spRating,
    "tipamount": tipamount,
    "per_hour_rate": perHourRate,
    "payment_status": paymentStatus,
    "commission_type": commissionType,
  };
}

class ChatUsersModel {
  int id;
  String username;
  String fname;
  String lname;
  String email;
  dynamic emailVerifiedAt;
  DateTime dob;
  Identity identity;
  String status;
  Image image;
  dynamic detail;
  String mobileNo;
  DateTime createdAt;
  DateTime updatedAt;
  String? verificationCode;
  String isVerified;
  String isEmailVerified;
  String isMobileVerified;
  String profileCompletion;
  String? customerId;
  String? lat;
  String? lng;
  dynamic accountId;
  dynamic personId;

  ChatUsersModel({
    required this.id,
    required this.username,
    required this.fname,
    required this.lname,
    required this.email,
    required this.emailVerifiedAt,
    required this.dob,
    required this.identity,
    required this.status,
    required this.image,
    required this.detail,
    required this.mobileNo,
    required this.createdAt,
    required this.updatedAt,
    required this.verificationCode,
    required this.isVerified,
    required this.isEmailVerified,
    required this.isMobileVerified,
    required this.profileCompletion,
    required this.customerId,
    required this.lat,
    required this.lng,
    required this.accountId,
    required this.personId,
  });

  factory ChatUsersModel.fromJson(Map<String, dynamic> json) => ChatUsersModel(
    id: json["id"],
    username: json["username"],
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    dob: DateTime.parse(json["dob"]),
    identity: identityValues.map[json["identity"]]!,
    status: json["status"],
    image: imageValues.map[json["image"]]!,
    detail: json["detail"],
    mobileNo: json["mobile_no"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    verificationCode: json["verification_code"],
    isVerified: json["is_verified"],
    isEmailVerified: json["is_email_verified"],
    isMobileVerified: json["is_mobile_verified"],
    profileCompletion: json["profile_completion"],
    customerId: json["customer_id"],
    lat: json["lat"],
    lng: json["lng"],
    accountId: json["account_id"],
    personId: json["person_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "fname": fname,
    "lname": lname,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "identity": identityValues.reverse[identity],
    "status": status,
    "image": imageValues.reverse[image],
    "detail": detail,
    "mobile_no": mobileNo,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "verification_code": verificationCode,
    "is_verified": isVerified,
    "is_email_verified": isEmailVerified,
    "is_mobile_verified": isMobileVerified,
    "profile_completion": profileCompletion,
    "customer_id": customerId,
    "lat": lat,
    "lng": lng,
    "account_id": accountId,
    "person_id": personId,
  };
}

enum Identity {
  EMPTY,
  IMAGES_USER_IDENTITY_8_YB_FQWI1_63_A583504995_F_PNG,
  IMAGES_USER_IDENTITY_DLTI1_C_ZP_63457_CB329697_JPEG
}

final identityValues = EnumValues({
  "": Identity.EMPTY,
  "images/userIdentity/8YBFqwi1__63a583504995f.png": Identity.IMAGES_USER_IDENTITY_8_YB_FQWI1_63_A583504995_F_PNG,
  "images/userIdentity/DLTI1cZP__63457cb329697.jpeg": Identity.IMAGES_USER_IDENTITY_DLTI1_C_ZP_63457_CB329697_JPEG
});

enum Image {
  IMAGES_USERS_S_YM_KAD4_H_63_A5835049518_PNG,
  IMAGES_USERS_USER_PLACEHOLDER_PNG,
  IMAGES_USERS_X_ZA_IC_PFX_6295_F1729_AC7_A_JPEG
}

final imageValues = EnumValues({
  "images/users/sYmKAD4H__63a5835049518.png": Image.IMAGES_USERS_S_YM_KAD4_H_63_A5835049518_PNG,
  "images/users/user_placeholder.png": Image.IMAGES_USERS_USER_PLACEHOLDER_PNG,
  "images/users/xZAIcPFX__6295f1729ac7a.jpeg": Image.IMAGES_USERS_X_ZA_IC_PFX_6295_F1729_AC7_A_JPEG
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
