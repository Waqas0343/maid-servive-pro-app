import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UserOrderModel {
  bool success;
  List<UserOrderListModel> data;
  String message;

  UserOrderModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserOrderModel.fromJson(Map<String, dynamic> json) => UserOrderModel(
    success: json["success"],
    data: List<UserOrderListModel>.from(json["data"].map((x) => UserOrderListModel.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class UserOrderListModel {
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
  RxString  status = RxString ('0');
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
  ServiceProviderModel serviceProvider;
  ServiceTakerModel serviceTaker;
  dynamic dispute;

  UserOrderListModel({
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
    required this.serviceProvider,
    required this.serviceTaker,
    required this.dispute,
  });

  factory UserOrderListModel.fromJson(Map<String, dynamic> json) => UserOrderListModel(
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
    additionalNotes: json["additional_notes"] ?? '',
    status: RxString(json["status"] ?? '0'),
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
    serviceProvider: ServiceProviderModel.fromJson(json["service_provider"]),
    serviceTaker: ServiceTakerModel.fromJson(json["service_taker"]),
    dispute: json["dispute"],
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
    "service_provider": serviceProvider.toJson(),
    "service_taker": serviceTaker.toJson(),
    "dispute": dispute,
  };
}

class ServiceProviderModel {
  int id;
  String userId;
  String level;
  String autoAccept;
  String netIncome;
  dynamic rating;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  ServiceProviderModel({
    required this.id,
    required this.userId,
    required this.level,
    required this.autoAccept,
    required this.netIncome,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) => ServiceProviderModel(
    id: json["id"],
    userId: json["user_id"],
    level: json["level"],
    autoAccept: json["auto_accept"],
    netIncome: json["net_income"],
    rating: json["rating"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "level": level,
    "auto_accept": autoAccept,
    "net_income": netIncome,
    "rating": rating,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
  };
}

class User {
  int id;
  String username;
  String fname;
  String lname;
  String email;
  dynamic emailVerifiedAt;
  DateTime dob;
  String identity;
  String status;
  String image;
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
  Wallet wallet;

  User({
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
    required this.wallet,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"] != null ? DateTime.parse(json["email_verified_at"]) : null,
    dob: DateTime.parse(json["dob"]),
    identity: json["identity"] ?? '',
    status: json["status"],
    image: json["image"] ?? '',
    detail: json["detail"],
    mobileNo: json["mobile_no"] ?? '',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    verificationCode: json["verification_code"],
    isVerified: json["is_verified"],
    isEmailVerified: json["is_email_verified"],
    isMobileVerified: json["is_mobile_verified"]?? '',
    profileCompletion: json["profile_completion"],
    customerId: json["customer_id"],
    lat: json["lat"] ?? '',
    lng: json["lng"] ?? '',
    accountId: json["account_id"],
    personId: json["person_id"],
    wallet: Wallet.fromJson(json["wallet"]),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "fname": fname,
    "lname": lname,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "identity": identity,
    "status": status,
    "image": image,
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
    "wallet": wallet.toJson(),
  };
}

class Wallet {
  int id;
  String userId;
  String balance;
  dynamic currencyId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic currency;

  Wallet({
    required this.id,
    required this.userId,
    required this.balance,
    required this.currencyId,
    required this.createdAt,
    required this.updatedAt,
    required this.currency,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["id"],
    userId: json["user_id"],
    balance: json["balance"],
    currencyId: json["currency_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "balance": balance,
    "currency_id": currencyId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "currency": currency,
  };
}

class ServiceTakerModel {
  int id;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic rating;
  User user;

  ServiceTakerModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
    required this.user,
  });

  factory ServiceTakerModel.fromJson(Map<String, dynamic> json) => ServiceTakerModel(
    id: json["id"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    rating: json["rating"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "rating": rating,
    "user": user.toJson(),
  };
}
