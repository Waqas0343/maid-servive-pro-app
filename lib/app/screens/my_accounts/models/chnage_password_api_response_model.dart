class ChangePasswordModel {
  bool success;
  ChangePasswordDataModel data;
  String message;

  ChangePasswordModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
    success: json["success"],
    data: ChangePasswordDataModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class ChangePasswordDataModel {
  int id;
  String username;
  String fname;
  String lname;
  String email;
  dynamic emailVerifiedAt;
  String dob;
  String identity;
  String status;
  String image;
  dynamic detail;
  String mobileNo;
  String createdAt;
  String updatedAt;
  String verificationCode;
  String isVerified;
  dynamic isEmailVerified;
  dynamic isMobileVerified;
  String profileCompletion;
  dynamic customerId;
  dynamic lat;
  dynamic lng;
  dynamic accountId;
  dynamic personId;

  ChangePasswordDataModel({
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

  factory ChangePasswordDataModel.fromJson(Map<String, dynamic> json) => ChangePasswordDataModel(
    id: json["id"] ?? 0,
    username: json["username"]?? '',
    fname: json["fname"]??'',
    lname: json["lname"] ?? '',
    email: json["email"] ?? '',
    emailVerifiedAt: json["email_verified_at"],
    dob: json["dob"] ?? '',
    identity: json["identity"] ?? '',
    status: json["status"]?? '',
    image: json["image"] ?? '',
    detail: json["detail"],
    mobileNo: json["mobile_no"]?? '',
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    verificationCode: json["verification_code"] ?? '',
    isVerified: json["is_verified"]?? '',
    isEmailVerified: json["is_email_verified"],
    isMobileVerified: json["is_mobile_verified"],
    profileCompletion: json["profile_completion"]?? '',
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
    "dob": dob,
    "identity": identity,
    "status": status,
    "image": image,
    "detail": detail,
    "mobile_no": mobileNo,
    "created_at": createdAt,
    "updated_at": updatedAt,
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
