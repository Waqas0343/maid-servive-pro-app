class UserServicesInformationModel {
  bool success;
  List<UserServicesInformationListModel> data;
  String message;

  UserServicesInformationModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserServicesInformationModel.fromJson(Map<String, dynamic> json) => UserServicesInformationModel(
    success: json["success"],
    data: List<UserServicesInformationListModel>.from(json["data"].map((x) => UserServicesInformationListModel.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class UserServicesInformationListModel {
  int id;
  String userId;
  String level;
  String autoAccept;
  String netIncome;
  dynamic rating;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  List<ServiceproviderService> serviceproviderServices;

  UserServicesInformationListModel({
    required this.id,
    required this.userId,
    required this.level,
    required this.autoAccept,
    required this.netIncome,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.serviceproviderServices,
  });

  factory UserServicesInformationListModel.fromJson(Map<String, dynamic> json) => UserServicesInformationListModel(
    id: json["id"],
    userId: json["user_id"],
    level: json["level"],
    autoAccept: json["auto_accept"],
    netIncome: json["net_income"],
    rating: json["rating"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
    serviceproviderServices: List<ServiceproviderService>.from(json["serviceprovider_services"].map((x) => ServiceproviderService.fromJson(x))),
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
    "serviceprovider_services": List<dynamic>.from(serviceproviderServices.map((x) => x.toJson())),
  };
}

class ServiceproviderService {
  int id;
  String serviceProviderId;
  String serviceTypeId;
  String education;
  String experience;
  String status;
  String description;
  dynamic language;
  DateTime createdAt;
  DateTime updatedAt;
  ServiceType serviceType;

  ServiceproviderService({
    required this.id,
    required this.serviceProviderId,
    required this.serviceTypeId,
    required this.education,
    required this.experience,
    required this.status,
    required this.description,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceType,
  });

  factory ServiceproviderService.fromJson(Map<String, dynamic> json) => ServiceproviderService(
    id: json["id"],
    serviceProviderId: json["service_provider_id"],
    serviceTypeId: json["service_type_id"],
    education: json["education"],
    experience: json["experience"],
    status: json["status"],
    description: json["description"],
    language: json["language"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    serviceType: ServiceType.fromJson(json["service_type"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_provider_id": serviceProviderId,
    "service_type_id": serviceTypeId,
    "education": education,
    "experience": experience,
    "status": status,
    "description": description,
    "language": language,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "service_type": serviceType.toJson(),
  };
}

class ServiceType {
  int id;
  String name;
  String description;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  ServicePrice servicePrice;
  List<LanguageUser> languageUsers;

  ServiceType({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.servicePrice,
    required this.languageUsers,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    servicePrice: ServicePrice.fromJson(json["service_price"]),
    languageUsers: List<LanguageUser>.from(json["language_users"].map((x) => LanguageUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "service_price": servicePrice.toJson(),
    "language_users": List<dynamic>.from(languageUsers.map((x) => x.toJson())),
  };
}

class LanguageUser {
  int id;
  String languageId;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String serviceTypeId;
  Currency language;

  LanguageUser({
    required this.id,
    required this.languageId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceTypeId,
    required this.language,
  });

  factory LanguageUser.fromJson(Map<String, dynamic> json) => LanguageUser(
    id: json["id"],
    languageId: json["language_id"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    serviceTypeId: json["service_type_id"],
    language: Currency.fromJson(json["language"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "language_id": languageId,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "service_type_id": serviceTypeId,
    "language": language.toJson(),
  };
}

class Currency {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Currency({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class ServicePrice {
  int id;
  String pricePerHour;
  String serviceTypeId;
  String currencyId;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  Currency currency;

  ServicePrice({
    required this.id,
    required this.pricePerHour,
    required this.serviceTypeId,
    required this.currencyId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.currency,
  });

  factory ServicePrice.fromJson(Map<String, dynamic> json) => ServicePrice(
    id: json["id"],
    pricePerHour: json["price_per_hour"],
    serviceTypeId: json["service_type_id"],
    currencyId: json["currency_id"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    currency: Currency.fromJson(json["currency"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price_per_hour": pricePerHour,
    "service_type_id": serviceTypeId,
    "currency_id": currencyId,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "currency": currency.toJson(),
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
  String lat;
  String lng;
  dynamic accountId;
  dynamic personId;
  Location location;

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
    required this.location,
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
    mobileNo: json["mobile_no"] ?? '',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    verificationCode: json["verification_code"] ?? '',
    isVerified: json["is_verified"],
    isEmailVerified: json["is_email_verified"] ?? '',
    isMobileVerified: json["is_mobile_verified"] ?? '',
    profileCompletion: json["profile_completion"],
    customerId: json["customer_id"],
    lat: json["lat"] ?? '',
    lng: json["lng"]?? '',
    accountId: json["account_id"],
    personId: json["person_id"],
    location: Location.fromJson(json["location"]),
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
    "location": location.toJson(),
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
    streetAddress: json["street_address"] ?? '',
    city: json["city"]?? '',
    state: json["state"]?? '',
    country: json["country"] ?? '',
    userId: json["user_id"]?? '',
    postalCode: json["postal_code"]?? '',
    defaultAddress: json["default_address"] ?? '',
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
