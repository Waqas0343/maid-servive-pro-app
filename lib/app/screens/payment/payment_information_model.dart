class PaymentModel {
  bool success;
  PaymentInformationModel data;
  String message;

  PaymentModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    success: json["success"],
    data: PaymentInformationModel.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class PaymentInformationModel {
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

  PaymentInformationModel({
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

  factory PaymentInformationModel.fromJson(Map<String, dynamic> json) => PaymentInformationModel(
    id: json["id"],
    userId: json["user_id"],
    paypalClientId: json["paypal_client_id"],
    paypalClientSecret: json["paypal_client_secret"],
    stripePublishableKey: json["stripe_publishable_key"],
    stripeSecret: json["stripe_secret"],
    createdAt:json["created_at"],
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
