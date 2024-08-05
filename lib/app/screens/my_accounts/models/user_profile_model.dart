class UserProfileModel {
  bool success;
  UserProfileDataModel data;
  String message;

  UserProfileModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    success: json["success"],
    data: UserProfileDataModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class UserProfileDataModel {
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
  dynamic lat;
  dynamic lng;
  dynamic accountId;
  dynamic personId;
  List<String> profileCompletionMessage;
  List<Role> roles;
  Location location;
  List<dynamic> serviceProviders;
  List<ServiceTaker> serviceTakers;

  UserProfileDataModel({
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
    required this.profileCompletionMessage,
    required this.roles,
    required this.location,
    required this.serviceProviders,
    required this.serviceTakers,
  });

  factory UserProfileDataModel.fromJson(Map<String, dynamic> json) => UserProfileDataModel(
    id: json["id"],
    username: json["username"],
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"]?? "",
    dob: DateTime.parse(json["dob"]),
    identity: json["identity"],
    status: json["status"],
    image: json["image"],
    detail: json["detail"],
    mobileNo: json["mobile_no"] ?? '',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    verificationCode: json["verification_code"] ?? '',
    isVerified: json["is_verified"],
    isEmailVerified: json["is_email_verified"] ?? "",
    isMobileVerified: json["is_mobile_verified"] ?? "",
    profileCompletion: json["profile_completion"] ?? "",
    customerId: json["customer_id"] ?? "",
    lat: json["lat"] ?? "",
    lng: json["lng"] ?? "",
    accountId: json["account_id"] ?? "",
    personId: json["person_id"],
    profileCompletionMessage: List<String>.from(json["profile_completion_message"].map((x) => x)),
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    location: Location.fromJson(json["location"]),
    serviceProviders: List<dynamic>.from(json["service_providers"].map((x) => x)),
    serviceTakers: List<ServiceTaker>.from(json["service_takers"].map((x) => ServiceTaker.fromJson(x))),
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
    "profile_completion_message": List<dynamic>.from(profileCompletionMessage.map((x) => x)),
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "location": location.toJson(),
    "service_providers": List<dynamic>.from(serviceProviders.map((x) => x)),
    "service_takers": List<dynamic>.from(serviceTakers.map((x) => x.toJson())),
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
  dynamic defaultAddress;
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
    streetAddress: json["street_address"] ?? "",
    city: json["city"] ?? "",
    state: json["state"] ?? "",
    country: json["country"] ?? "",
    userId: json["user_id"] ?? "",
    postalCode: json["postal_code"] ?? "",
    defaultAddress: json["default_address"] ?? "",
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

class ServiceTaker {
  int id;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic rating;
  List<dynamic> orders;

  ServiceTaker({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
    required this.orders,
  });

  factory ServiceTaker.fromJson(Map<String, dynamic> json) => ServiceTaker(
    id: json["id"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    rating: json["rating"],
    orders: List<dynamic>.from(json["orders"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "rating": rating,
    "orders": List<dynamic>.from(orders.map((x) => x)),
  };
}
