class LoginUserModel {
  final int? userId;
  final String? authorizationToken;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final String? email;
  final dynamic image;
  final String? complete;

  LoginUserModel({
    this.userId,
    this.authorizationToken,
    this.userName,
    this.firstName,
    this.lastName,
    this.image,
    this.email,
    this.complete,
  });
}
