class UserDisputeModel {
  bool success;
  UserDisputeDataModel data;
  String message;

  UserDisputeModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserDisputeModel.fromJson(Map<String, dynamic> json) => UserDisputeModel(
    success: json["success"],
    data: UserDisputeDataModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class UserDisputeDataModel {
  int currentPage;
  List<UserDisputeDataListModel> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  UserDisputeDataModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory UserDisputeDataModel.fromJson(Map<String, dynamic> json) => UserDisputeDataModel(
    currentPage: json["current_page"],
    data: List<UserDisputeDataListModel>.from(json["data"].map((x) => UserDisputeDataListModel.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"]??0,
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"]?? 0,
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class UserDisputeDataListModel {
  int id;
  String userId;
  String openFor;
  String orderId;
  String title;
  String description;
  dynamic image;
  String status;
  dynamic resolvedFor;
  DateTime createdAt;
  DateTime updatedAt;
  User userFor;
  User user;
  Order order;

  UserDisputeDataListModel({
    required this.id,
    required this.userId,
    required this.openFor,
    required this.orderId,
    required this.title,
    required this.description,
    required this.image,
    required this.status,
    required this.resolvedFor,
    required this.createdAt,
    required this.updatedAt,
    required this.userFor,
    required this.user,
    required this.order,
  });

  factory UserDisputeDataListModel.fromJson(Map<String, dynamic> json) => UserDisputeDataListModel(
    id: json["id"],
    userId: json["user_id"],
    openFor: json["open_for"],
    orderId: json["order_id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    resolvedFor: json["resolved_for"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    userFor: User.fromJson(json["user_for"]),
    user: User.fromJson(json["user"]),
    order: Order.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "open_for": openFor,
    "order_id": orderId,
    "title": title,
    "description": description,
    "image": image,
    "status": status,
    "resolved_for": resolvedFor,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user_for": userFor.toJson(),
    "user": user.toJson(),
    "order": order.toJson(),
  };
}

class Order {
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
  String verificationCode;
  String isVerified;
  String isEmailVerified;
  String isMobileVerified;
  String profileCompletion;
  dynamic customerId;
  String? lat;
  String? lng;
  dynamic accountId;
  dynamic personId;

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
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
