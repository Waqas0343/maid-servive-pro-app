class UserStatusModel {
  bool success;
  UserStatusDataModel data;
  String message;

  UserStatusModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserStatusModel.fromJson(Map<String, dynamic> json) => UserStatusModel(
    success: json["success"],
    data: UserStatusDataModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class UserStatusDataModel {
  int id;
  String userId;
  String level;
  String autoAccept;
  String netIncome;
  dynamic rating;
  DateTime createdAt;
  DateTime updatedAt;
  String completedOrders;
  String pendingOrders;
  int totalOrders;
  User user;
  List<dynamic> serviceproviderServices;
  List<Order> orders;

  UserStatusDataModel({
    required this.id,
    required this.userId,
    required this.level,
    required this.autoAccept,
    required this.netIncome,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.completedOrders,
    required this.pendingOrders,
    required this.totalOrders,
    required this.user,
    required this.serviceproviderServices,
    required this.orders,
  });

  factory UserStatusDataModel.fromJson(Map<String, dynamic> json) => UserStatusDataModel(
    id: json["id"],
    userId: json["user_id"],
    level: json["level"],
    autoAccept: json["auto_accept"],
    netIncome: json["net_income"],
    rating: json["rating"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    completedOrders: json["completed_orders"] ?? '',
    pendingOrders: json["pending_orders"] ?? '',
    totalOrders: json["total_orders"],
    user: User.fromJson(json["user"]),
    serviceproviderServices: List<dynamic>.from(json["serviceprovider_services"].map((x) => x)),
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
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
    "completed_orders": completedOrders,
    "pending_orders": pendingOrders,
    "total_orders": totalOrders,
    "user": user.toJson(),
    "serviceprovider_services": List<dynamic>.from(serviceproviderServices.map((x) => x)),
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Order {
  int id;
  String serviceTakerId;
  String serviceProviderId;
  String orderKey;
  String? requestAccepted;
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
  ServiceTaker serviceTaker;

  Order({
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
    required this.serviceTaker,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
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
    serviceTaker: ServiceTaker.fromJson(json["service_taker"]),
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
    "service_taker": serviceTaker.toJson(),
  };
}

class ServiceTaker {
  int id;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic rating;
  User user;

  ServiceTaker({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
    required this.user,
  });

  factory ServiceTaker.fromJson(Map<String, dynamic> json) => ServiceTaker(
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
  String? mobileNo;
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
  Location? location;
  dynamic servicePrice;
  List<Role>? roles;
  List<WorkingSlot>? workingSlots;

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
    this.location,
    this.servicePrice,
    this.roles,
    this.workingSlots,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    dob: DateTime.parse(json["dob"]),
    identity: json["identity"],
    status: json["status"],
    image: json["image"],
    detail: json["detail"],
    mobileNo: json["mobile_no"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    verificationCode: json["verification_code"],
    isVerified: json["is_verified"],
    isEmailVerified: json["is_email_verified"]?? '',
    isMobileVerified: json["is_mobile_verified"] ?? '',
    profileCompletion: json["profile_completion"],
    customerId: json["customer_id"],
    lat: json["lat"],
    lng: json["lng"],
    accountId: json["account_id"],
    personId: json["person_id"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    servicePrice: json["service_price"],
    roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
    workingSlots: json["working_slots"] == null ? [] : List<WorkingSlot>.from(json["working_slots"]!.map((x) => WorkingSlot.fromJson(x))),
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
    "location": location?.toJson(),
    "service_price": servicePrice,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
    "working_slots": workingSlots == null ? [] : List<dynamic>.from(workingSlots!.map((x) => x.toJson())),
  };
}

class Location {
  int id;
  String streetAddress;
  String city;
  String state;
  String country;
  String userId;
  String postalCode;
  String defaultAddress;
  DateTime createdAt;
  DateTime updatedAt;

  Location({
    required this.id,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.country,
    required this.userId,
    required this.postalCode,
    required this.defaultAddress,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    streetAddress: json["street_address"]??'',
    city: json["city"] ?? '',
    state: json["state"] ?? '',
    country: json["country"] ?? '',
    userId: json["user_id"] ?? '',
    postalCode: json["postal_code"] ?? '',
    defaultAddress: json["default_address"]?? '',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "street_address": streetAddress,
    "city": city,
    "state": state,
    "country": country,
    "user_id": userId,
    "postal_code": postalCode,
    "default_address": defaultAddress,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Role {
  int id;
  String name;
  String guardName;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  String modelId;
  String roleId;
  String modelType;

  Pivot({
    required this.modelId,
    required this.roleId,
    required this.modelType,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    modelId: json["model_id"],
    roleId: json["role_id"],
    modelType: json["model_type"],
  );

  Map<String, dynamic> toJson() => {
    "model_id": modelId,
    "role_id": roleId,
    "model_type": modelType,
  };
}

class WorkingSlot {
  int id;
  String dayId;
  String slotId;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  HourlySlots hourlySlots;

  WorkingSlot({
    required this.id,
    required this.dayId,
    required this.slotId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.hourlySlots,
  });

  factory WorkingSlot.fromJson(Map<String, dynamic> json) => WorkingSlot(
    id: json["id"],
    dayId: json["day_id"],
    slotId: json["slot_id"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    status: json["status"],
    hourlySlots: HourlySlots.fromJson(json["hourly_slots"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day_id": dayId,
    "slot_id": slotId,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "status": status,
    "hourly_slots": hourlySlots.toJson(),
  };
}

class HourlySlots {
  int id;
  String slotStartTime;
  String slotEndTime;
  DateTime createdAt;
  DateTime updatedAt;

  HourlySlots({
    required this.id,
    required this.slotStartTime,
    required this.slotEndTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HourlySlots.fromJson(Map<String, dynamic> json) => HourlySlots(
    id: json["id"],
    slotStartTime: json["slot_start_time"],
    slotEndTime: json["slot_end_time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slot_start_time": slotStartTime,
    "slot_end_time": slotEndTime,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
