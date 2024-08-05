class LoginResponseModel {
  bool success;
  LoginResponseDataModel data;
  String message;

  LoginResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    success: json["success"],
    data: LoginResponseDataModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class LoginResponseDataModel {
  String accessToken;
  String refreshToken;
  int id;
  String username;
  String profileCompletion;
  String fullName;
  String email;
  dynamic isEmailVerified;
  dynamic isMobileVerified;
  String avatar;
  RoleModel role;
  List<AbilityModel> ability;
  ConfigurationModel configurations;

  LoginResponseDataModel({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.username,
    required this.profileCompletion,
    required this.fullName,
    required this.email,
    required this.isEmailVerified,
    required this.isMobileVerified,
    required this.avatar,
    required this.role,
    required this.ability,
    required this.configurations,
  });

  factory LoginResponseDataModel.fromJson(Map<String, dynamic> json) => LoginResponseDataModel(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    id: json["id"],
    username: json["username"],
    profileCompletion: json["profile_completion"],
    fullName: json["fullName"],
    email: json["email"],
    isEmailVerified: json["is_email_verified"],
    isMobileVerified: json["is_mobile_verified"],
    avatar: json["avatar"],
    role: RoleModel.fromJson(json["role"]),
    ability: List<AbilityModel>.from(json["ability"].map((x) => AbilityModel.fromJson(x))),
    configurations: ConfigurationModel.fromJson(json["configurations"]),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "id": id,
    "username": username,
    "profile_completion": profileCompletion,
    "fullName": fullName,
    "email": email,
    "is_email_verified": isEmailVerified,
    "is_mobile_verified": isMobileVerified,
    "avatar": avatar,
    "role": role.toJson(),
    "ability": List<dynamic>.from(ability.map((x) => x.toJson())),
    "configurations": configurations.toJson(),
  };
}

class RoleModel {
  int id;
  String name;
  String guardName;
  String createdAt;
  String updatedAt;
  PivotModel pivot;
  List<PermissionModel> permissions;

  RoleModel({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
    required this.permissions,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    pivot: PivotModel.fromJson(json["pivot"]),
    permissions: List<PermissionModel>.from(json["permissions"].map((x) => PermissionModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "pivot": pivot.toJson(),
    "permissions": List<dynamic>.from(permissions.map((x) => x.toJson())),
  };
}

class PivotModel {
  String modelId;
  String roleId;
  String modelType;

  PivotModel({
    required this.modelId,
    required this.roleId,
    required this.modelType,
  });

  factory PivotModel.fromJson(Map<String, dynamic> json) => PivotModel(
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

class PermissionModel {
  int id;
  String name;
  String guardName;
  String createdAt;
  String updatedAt;
  String action;
  String resource;

  PermissionModel({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.action,
    required this.resource,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) => PermissionModel(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    action: json["action"],
    resource: json["resource"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "action": action,
    "resource": resource,
  };
}

class AbilityModel {
  int id;
  String name;
  String guardName;
  String createdAt;
  String updatedAt;
  String action;
  String resource;
  PivotModel pivot;

  AbilityModel({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.action,
    required this.resource,
    required this.pivot,
  });

  factory AbilityModel.fromJson(Map<String, dynamic> json) => AbilityModel(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    action: json["action"],
    resource: json["resource"],
    pivot: PivotModel.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "action": action,
    "resource": resource,
    "pivot": pivot.toJson(),
  };
}

class ConfigurationModel {
  int id;
  String userId;
  dynamic paypalClientId;
  dynamic paypalClientSecret;
  dynamic stripePublishableKey;
  dynamic stripeSecret;
  String createdAt;
  String updatedAt;
  dynamic cardId;
  dynamic cardNo;
  dynamic expiryMonth;
  dynamic expiryYear;
  dynamic cvc;
  dynamic zipCode;
  String defaultStatus;
  dynamic cardBrand;

  ConfigurationModel({
    required this.id,
    required this.userId,
    required this.paypalClientId,
    required this.paypalClientSecret,
    required this.stripePublishableKey,
    required this.stripeSecret,
    required this.createdAt,
    required this.updatedAt,
    required this.cardId,
    required this.cardNo,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvc,
    required this.zipCode,
    required this.defaultStatus,
    required this.cardBrand,
  });

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) => ConfigurationModel(
    id: json["id"],
    userId: json["user_id"],
    paypalClientId: json["paypal_client_id"],
    paypalClientSecret: json["paypal_client_secret"],
    stripePublishableKey: json["stripe_publishable_key"],
    stripeSecret: json["stripe_secret"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    cardId: json["card_id"],
    cardNo: json["card_no"],
    expiryMonth: json["expiry_month"],
    expiryYear: json["expiry_year"],
    cvc: json["cvc"],
    zipCode: json["zip_code"],
    defaultStatus: json["default_status"],
    cardBrand: json["card_brand"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "paypal_client_id": paypalClientId,
    "paypal_client_secret": paypalClientSecret,
    "stripe_publishable_key": stripePublishableKey,
    "stripe_secret": stripeSecret,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "card_id": cardId,
    "card_no": cardNo,
    "expiry_month": expiryMonth,
    "expiry_year": expiryYear,
    "cvc": cvc,
    "zip_code": zipCode,
    "default_status": defaultStatus,
    "card_brand": cardBrand,
  };
}
