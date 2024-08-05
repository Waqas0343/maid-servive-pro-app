import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_core/src/get_main.dart';
import 'package:go_maids_pro/helpers/server/server_config.dart';
import '../../app/screens/home/model/user_status_model_for_home.dart';
import '../../app/screens/messages/models/single_chat_model.dart';
import '../../app/screens/messages/models/user_chats_model.dart';
import '../../app/screens/my_Orders/models/user_Order_model.dart';
import '../../app/screens/my_accounts/models/chnage_password_api_response_model.dart';
import '../../app/screens/my_accounts/models/currency_model.dart';
import '../../app/screens/my_accounts/models/get_user_services_informatiom_model.dart';
import '../../app/screens/my_accounts/models/languages_model.dart';
import '../../app/screens/my_accounts/models/set_user_availbility_model.dart';
import '../../app/screens/my_accounts/models/user_availability_week_days_model.dart';
import '../../app/screens/my_accounts/models/user_profile_model.dart';
import '../../app/screens/my_accounts/models/user_services_model.dart';
import '../../app/screens/my_dispute/models/get_user_dispute_model.dart';
import '../../app/screens/noification/notification_model.dart';
import '../../app/screens/payment/payment_information_model.dart';
import '../../app/services/preferences.dart';
import '../../app_assets/app_styles/strings/app_constants.dart';
import '../../app_assets/debug/debug_pointer.dart';
import '../toaster.dart';

class ApiFetch extends getx.GetxService {
  static Dio dio = Dio();
  String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";

  static Future<Map<String, dynamic>?> login(Map<String, dynamic> data) async {
    Response response;
    try {
      Debug.log(ServerConfig.login + data.toString());
      response = await dio.post(
        ServerConfig.login,
        data: data,
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final loginResponse = response.data;
        if (loginResponse['success'] == true) {
          // Toaster.showToast(loginResponse['message']);
        } else {
          final errorMessage = loginResponse['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Please Check Your Login Credential.!");
          }
        }
        Debug.log(loginResponse);
        return loginResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> forgotPassword(
      Map<String, dynamic> data) async {
    Response response;
    try {
      Debug.log(ServerConfig.forgotPassword + data.toString());
      response = await dio.post(
        ServerConfig.forgotPassword,
        data: data,
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final signUpResponse = response.data;
        Debug.log(signUpResponse);
        Toaster.showToast('New password suggestion has been send to your email');
        return signUpResponse;
      } catch (e) {
        Debug.log(e);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> usersSignUp(
      Map<String, dynamic> data) async {
    Response response;
    try {
      Debug.log(ServerConfig.signUp + data.toString());
      response = await dio.post(
        ServerConfig.signUp,
        data: data,
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final signUpResponse = response.data;
        Debug.log(signUpResponse);
        if (signUpResponse['success'] == true) {
          // Toaster.showToast(signUpResponse['message']);
        } else {
          final errorMessage = signUpResponse['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        return signUpResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> sendCodeToMail(
      Map<String, dynamic> data) async {
    Response response;
    try {
      Debug.log(ServerConfig.sendCodeEmail + data.toString());
      response = await dio.post(
        ServerConfig.sendCodeEmail,
        data: data,
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final signUpResponse = response.data;
        Debug.log(signUpResponse);
        return signUpResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> verifyMailPinCode(
      Map<String, dynamic> data) async {
    Response response;
    try {
      Debug.log(ServerConfig.verifyPinCode + data.toString());
      response = await dio.post(
        ServerConfig.verifyPinCode,
        data: data,
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final signUpResponse = response.data;
        Debug.log(signUpResponse);
        return signUpResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> sendCodeToMobile(
      Map<String, dynamic> data) async {
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
    Response response;
    try {
      Debug.log(ServerConfig.sendCodeNumber + data.toString());
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.post(
        ServerConfig.sendCodeNumber,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());

      try {
        final signUpResponse = response.data;
        Debug.log(signUpResponse);
        if (signUpResponse['success'] == true) {
          // Toaster.showToast(signUpResponse['message']);
        } else {
          final errorMessage = signUpResponse['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        return signUpResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> verifyMobilePinCode(Map<String, dynamic> data) async {
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
    Response response;
    try {
      Debug.log(ServerConfig.verifyMobileCode + data.toString());
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.post(
        ServerConfig.verifyMobileCode,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final signUpResponse = response.data;
        Debug.log(signUpResponse);
        return signUpResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<ChangePasswordModel?> changeUserPassword(
      Map<String, dynamic> data) async {
    int? userID = Get.find<Preferences>().getInt(Keys.userId);
    String url = '${ServerConfig.changePassword}/$userID';
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";

    try {
      final headers = {
        "Authorization": "Bearer $token",
      };
      Response response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        Debug.log(response.data.toString());
        final signUpResponse = ChangePasswordModel.fromJson(response.data);
        return signUpResponse;
      } else {
        return null;
      }
    } catch (e, s) {
      Debug.log(e);
      Debug.log(s);
      return null;
    }
  }

  static Future<UserProfileModel?> getUserProfile(int? query) async {
    Response response;
    UserProfileModel? userProfile;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = '${ServerConfig.userProfile}/${query.toString()}';
      Debug.log(url);
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        '${ServerConfig.userProfile}/$query',
        options: Options(
          headers: headers,
        ),
      );
    } catch (e, s) {
      Debug.log('Error fetching user profile: $e');
      Debug.log(s);
      return userProfile;
    }
    if (response.statusCode == 200) {
      try {
        final userProfileResponse = UserProfileModel.fromJson(response.data);
        Debug.log(response.data);
        userProfile = userProfileResponse;
      } catch (e, s) {
        Debug.log('Error parsing user profile response: $e');
        Debug.log(s);
      }
    }
    return userProfile;
  }

  static Future<List<UserServicesSubDataListModel>?> getUserServices() async {
    Response response;
    List<UserServicesSubDataListModel>? userServicesList;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = ServerConfig.userServices;
      Debug.log(url);
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final userServicesModel = UserServicesModel.fromJson(jsonResponse);
        userServicesList = userServicesModel.data.data;
        Debug.log(response.data);
        // Toaster.showToast(userServicesModel.message);
      } else {
        Debug.log('Failed to fetch user services: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      Debug.log('Error fetching user services: $error');
      Debug.log(stackTrace);
    }
    return userServicesList;
  }

  static Future<List<LanguagesDataListModel>?> getLanguages() async {
    Response response;
    List<LanguagesDataListModel>? userServicesList;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = ServerConfig.getLanguages;
      Debug.log(url);
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final userServicesModel = LanguagesModel.fromJson(jsonResponse);
        userServicesList = userServicesModel.data.data;
        Debug.log(response.data);
        // Toaster.showToast(userServicesModel.message);
      } else {
        Debug.log('Failed to fetch user services: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      Debug.log('Error fetching user services: $error');
      Debug.log(stackTrace);
    }
    return userServicesList;
  }

  static Future<List<GetCurrencyDataListModel>?> getCurrency() async {
    Response response;
    List<GetCurrencyDataListModel>? currencyList;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = ServerConfig.getCurrency;
      Debug.log(url);
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final currencyModel = GetCurrencyModel.fromJson(jsonResponse);
        currencyList = currencyModel.data.data;
        Debug.log(response.data);
        // Toaster.showToast(currencyModel.message);
      } else {
        Debug.log('Failed to fetch user services: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      Debug.log('Error fetching user services: $error');
      Debug.log(stackTrace);
    }
    return currencyList;
  }

  static Future<Map<String, dynamic>?> saveUserServices(
      Map<String, dynamic> data) async {
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
    Response response;
    try {
      Debug.log(ServerConfig.saveUserServices + data.toString());
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.post(
        ServerConfig.saveUserServices,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final loginResponse = response.data;
        if (loginResponse['success'] == true) {
          // Toaster.showToast(loginResponse['message']);
        } else {
          final errorMessage = loginResponse['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        Debug.log(loginResponse);
        return loginResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<UserWeekDaysDataListModel>?> getUserWeekDays() async {
    Response response;
    List<UserWeekDaysDataListModel>? userWeekList;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = ServerConfig.userWeekDays;
      Debug.log(url);
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final userWeekModel = UserWeekDaysModel.fromJson(jsonResponse);
        userWeekList = userWeekModel.data.data;
        Debug.log(response.data);
        Toaster.showToast(userWeekModel.message);
      } else {
        Debug.log('Failed to fetch user services: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      Debug.log('Error fetching user services: $error');
      Debug.log(stackTrace);
    }
    return userWeekList;
  }

  static Future<List<UserOrderListModel>?> getUserOrderData() async {
    Response response;
    List<UserOrderListModel>? userOrderList;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = ServerConfig.getUserOrders;
      Debug.log(url);
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final List<dynamic> data = jsonResponse['data'];
        userOrderList = data
            .map((orderData) => UserOrderListModel.fromJson(orderData))
            .toList();
        Debug.log(data);
        // Toaster.showToast(jsonResponse['message']);
      } else {
        Debug.log('Failed to fetch user services: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      Debug.log('Error fetching user services: $error');
      Debug.log(stackTrace);
    }
    return userOrderList;
  }

  static Future<UserDisputeDataModel?> getUserDispute(int? query) async {
    Response response;
    UserDisputeDataModel? userDisputeData;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = '${ServerConfig.getDispute}/${query.toString()}';
      Debug.log(url);
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        userDisputeData = UserDisputeDataModel.fromJson(jsonResponse['data']);
        Debug.log(jsonResponse['data']);
        Toaster.showToast(jsonResponse['message']);
      } else {
        Debug.log('Failed to fetch user disputes: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      Debug.log('Error fetching user disputes: $error');
      Debug.log(stackTrace);
    }
    return userDisputeData;
  }

  static Future<Map<String, dynamic>?> createNewDispute(
      Map<String, dynamic> data) async {
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
    Response response;
    try {
      Debug.log(ServerConfig.createDispute + data.toString());
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.post(
        ServerConfig.createDispute,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final loginResponse = response.data;
        if (loginResponse['success'] == true) {
          Toaster.showToast(loginResponse['message']);
        } else {
          final errorMessage = loginResponse['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        Debug.log(loginResponse);
        return loginResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> configurePaymentMethod(
      Map<String, dynamic> data) async {
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
    Response response;
    try {
      Debug.log(ServerConfig.configurePaymentMethod + data.toString());
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.put(
        ServerConfig.configurePaymentMethod,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final loginResponse = response.data;
        if (loginResponse['success'] == true) {
          Toaster.showToast(loginResponse['message']);
        } else {
          final errorMessage = loginResponse['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        Debug.log(loginResponse);
        return loginResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> configureBankPaymentMethod(
      Map<String, dynamic> data) async {
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
    Response response;
    try {
      Debug.log(ServerConfig.addBankPaymentMethod + data.toString());
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.post(
        ServerConfig.addBankPaymentMethod,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final loginResponse = response.data;
        if (loginResponse['success'] == true) {
          Toaster.showToast(loginResponse['message']);
        } else {
          final errorMessage = loginResponse['message'];
          if (errorMessage != null) {
            Toaster.showToast(loginResponse['message']);
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        Debug.log(loginResponse);
        return loginResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<ChatDataModel>?> getUserChatModelData() async {
    Response response;
    List<ChatDataModel>? chatDataList;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = ServerConfig.userChatApi;
      Debug.log(url);
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final chatModel = ChatModel.fromJson(jsonResponse);
        chatDataList = chatModel.data;
        Debug.log(response.data);
        // Toaster.showToast(chatModel.message);
      } else {
        Debug.log('Failed to fetch chats: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      Debug.log('Error fetching chats: $error');
      Debug.log(stackTrace);
    }
    return chatDataList;
  }

  static Future<List<NotificationDataListModel>?> getUserNotification(
      query) async {
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = '${ServerConfig.getUserNotification}/${query.toString()}';
      Debug.log(url);
      final headers = {"Authorization": "Bearer $token"};

      final response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse.containsKey('data')) {
          final List<dynamic> notificationList = jsonResponse['data'];
          final List<NotificationDataListModel> userNotificationData =
              notificationList
                  .map((json) => NotificationDataListModel.fromJson(json))
                  .toList();
          // Toaster.showToast(jsonResponse['message']);
          return userNotificationData;
        } else {
          Debug.log('Data field not found in API response.');
          return null;
        }
      } else {
        Debug.log('Failed to fetch user notifications: ${response.statusCode}');
        return null;
      }
    } catch (error, stackTrace) {
      Debug.log('Error fetching user notifications: $error');
      Debug.log(stackTrace);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> saveUserContactUsData(
      Map<String, dynamic> data) async {
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
    Response response;
    try {
      Debug.log(ServerConfig.addContactUsData + data.toString());
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.post(
        ServerConfig.addContactUsData,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final loginResponse = response.data;
        if (loginResponse['success'] == true) {
          Toaster.showToast(loginResponse['message']);
        } else {
          final errorMessage = loginResponse['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        Debug.log(loginResponse);
        return loginResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<UserStatusModel?> getUserPaymentForHomeStatus(
      int? query) async {
    Response response;
    UserStatusModel? userStatusModel;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = '${ServerConfig.getUserPaymentStatus}/${query.toString()}';
      Debug.log(url);
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        '${ServerConfig.getUserPaymentStatus}/$query',
        options: Options(
          headers: headers,
        ),
      );
    } catch (e, s) {
      Debug.log('Error fetching user profile: $e');
      Debug.log(s);
      return userStatusModel;
    }
    if (response.statusCode == 200) {
      try {
        final userProfileResponse = UserStatusModel.fromJson(response.data);
        Debug.log(response.data);
        // Toaster.showToast(userProfileResponse.message); // Show message from API response
        userStatusModel = userProfileResponse;
      } catch (e, s) {
        Debug.log('Error parsing user profile response: $e');
        Debug.log(s);
      }
    }
    return userStatusModel;
  }

  static Future<Map<String, dynamic>?> readNotification(
      Map<String, dynamic> data) async {
    Response response;
    try {
      Debug.log(ServerConfig.readUserNotification + data.toString());
      response = await dio.put(
        ServerConfig.readUserNotification,
        data: data,
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final loginResponse = response.data;
        if (loginResponse['success'] == true) {
          Toaster.showToast(loginResponse['message']);
        } else {
          final errorMessage = loginResponse['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        Debug.log(loginResponse);
        return loginResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> saveUserProfileDetail(
      Map<String, dynamic> data) async {
    Response response;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;
      Debug.log(
          '${ServerConfig.saveUserProfile}/$userID/profile' + data.toString());
      String apiUrl = '${ServerConfig.saveUserProfile}/$userID/profile';
      Debug.log(apiUrl + data.toString());
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.put(
        apiUrl,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final responseData = response.data;
        if (responseData['success'] == true) {
          // Toaster.showToast(responseData['message']);
        } else {
          final errorMessage = responseData['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        return responseData;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      Debug.log('Request failed with status: ${response.statusCode}');
      Toaster.showToast('Failed to save user profile');
      return null;
    }
  }

  static Future<List<String>> getAutocompletePredictions(
      String input, String apiKey) async {
    try {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/js/AutocompletionService.GetPredictionsJson?input=$input&key=$apiKey');
      Debug.log(url);
      final response = await dio.get(url.toString());

      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final predictions = data['predictions'] as List<dynamic>;
        return predictions
            .map((prediction) => prediction['description'].toString())
            .toList();
      } else {
        throw Exception('Failed to fetch predictions');
      }
    } catch (e) {
      throw Exception('Error fetching predictions: $e');
    }
  }

  static Future<UserAvailabilityListModel?> getUserAvailabilityTimeSlot(int? query) async {
    Response response;
    UserAvailabilityListModel? userStatusModel;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url =
          '${ServerConfig.getUserAvailabilityTimeSlot}${query.toString()}/workingslot?';
      Debug.log(url);
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e, s) {
      Debug.log('Error fetching user profile: $e');
      Debug.log(s);
      return userStatusModel;
    }
    if (response.statusCode == 200) {
      try {
        final userProfileResponse =
            UserAvailabilityModel.fromJson(response.data);
        Debug.log(response.data);
        // Toaster.showToast(userProfileResponse.message);
        userStatusModel = userProfileResponse.data;
      } catch (e, s) {
        Debug.log('Error parsing user profile response: $e');
        Debug.log(s);
      }
    }
    return userStatusModel;
  }

  static Future<Map<String, dynamic>?> saveUserAvailabilityTime(
      Map<String, dynamic> data) async {
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
    Response response;
    try {
      String apiUrl = '${ServerConfig.addUserAvailabilityTime}';
      Debug.log(apiUrl);
      Debug.log(data);

      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.post(
        apiUrl,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final responseData = response.data;
        if (responseData['success'] == true) {
          // Toaster.showToast(responseData['message']);
        } else {
          final errorMessage = responseData['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        Debug.log(responseData);
        return responseData;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      Debug.log('Request failed with status: ${response.statusCode}');
      Toaster.showToast('Failed to save user profile');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> saveUserAvailabilityDaySlot(
      Map<String, dynamic> data) async {
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
    Response response;
    try {
      String apiUrl = '${ServerConfig.addUserWorkingDaySlot}';
      Debug.log(apiUrl);
      Debug.log(data);

      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.post(
        apiUrl,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final responseData = response.data;
        if (responseData['success'] == true) {
          // Toaster.showToast(responseData['message']);
        } else {
          final errorMessage = responseData['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        Debug.log(responseData);
        return responseData;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      Debug.log('Request failed with status: ${response.statusCode}');
      Toaster.showToast('Failed to save user profile');
      return null;
    }
  }

  static Future<bool> deleteWeekDaySlotForUser(String data) async {
    try {
      Debug.log(ServerConfig.deleteUserWorkingDaySlot + data);
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      final headers = {
        "Authorization": "Bearer $token",
      };
      Response response = await dio.delete(
        ServerConfig.deleteUserWorkingDaySlot + data,
        options: Options(headers: headers),
      );

      Debug.log(response);
      if (response.statusCode == 200) {
        if (response.data.containsKey('success') &&
            response.data['success'] == true) {
          Debug.log(response.data.toString());
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e, s) {
      Debug.log(e);
      Debug.log(s);
      return false;
    }
  }

  static Future<Map<String, dynamic>?> addNewUserAvailabilityDaySlot(Map<String, dynamic> data) async {
    int? userID = Get.find<Preferences>().getInt(Keys.userId) ?? null;
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
    Response response;
    try {
      String apiUrl = '${ServerConfig.addNewUserWorkingDaySlot}/${userID}/workingslot?';
      Debug.log(apiUrl);
      Debug.log(data);

      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.put(
        apiUrl,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final responseData = response.data;
        if (responseData['success'] == true) {
        } else {
          final errorMessage = responseData['error_message'];
          Debug.log(errorMessage);
        }
        Debug.log(responseData);
        return responseData;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      Debug.log('Request failed with status: ${response.statusCode}');
      Toaster.showToast('Failed to save user profile');
      return null;
    }
  }

  static Future<List<ChatMessage>?> getChatAgainstSingleUser(int? query) async {
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = '${ServerConfig.singleUserChatApi}/$query';
      Debug.log(url);
      Debug.log(token);
      final headers = {
        "Authorization": "Bearer $token",
      };
      final response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      Debug.log('Response: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final chatMessagesList = responseData['data'] as List<dynamic>;
        return chatMessagesList
            .map((json) => ChatMessage.fromJson(json))
            .toList();
      } else {
        print(
            'Failed to fetch chat messages. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e, s) {
      print('Error fetching chat messages: $e');
      print('Error stack trace: $s');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> addNewChatMessage(Map<String, dynamic> data) async {
    String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
    Response response;
    try {
      Debug.log(ServerConfig.addNewChatMessage + data.toString());
      Debug.log(token);

      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.post(
        ServerConfig.addNewChatMessage,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e, s) {
      Debug.log(e);
      Debug.log(s);
      return null;
    }
    Debug.log(response);
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final loginResponse = response.data;
        if (loginResponse['success'] == true) {
          Toaster.showToast(loginResponse['message']);
        } else {
          final errorMessage = loginResponse['error_message'];
          if (errorMessage != null) {
            Toaster.showToast(errorMessage.join('\n'));
          } else {
            Toaster.showToast("Unknown error occurred");
          }
        }
        Debug.log(loginResponse);
        return loginResponse;
      } catch (e, s) {
        Debug.log(e);
        Debug.log(s);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<UserServicesInformationListModel>?> getUserServicesInformation(queryParameters) async {
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url =
          '${ServerConfig.getUserServicesInformation}/$queryParameters/serviceprovider';
      Debug.log(url);
      final headers = {"Authorization": "Bearer $token"};

      final response = await dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        Debug.log(response.data);
        final jsonResponse = response.data;
        if (jsonResponse.containsKey('data')) {
          final List<dynamic> dataList = jsonResponse['data'];
          final List<UserServicesInformationListModel> userDataList = dataList
              .map((json) => UserServicesInformationListModel.fromJson(json))
              .toList();
          // Toaster.showToast(jsonResponse['message']);
          return userDataList;
        } else {
          print('Data field not found in API response.');
          return null;
        }
      } else {
        print(
            'Failed to fetch user services information: ${response.statusCode}');
        return null;
      }
    } catch (error, s) {
      print('Error fetching user services information: $error');
      print(s);

      return null;
    }
  }

  static Future<Map<String, dynamic>?> changOrderStatus(Map<String, dynamic> data, OrderID) async {
    Response response;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      Debug.log(ServerConfig.changeOrderStatus + data.toString());
      final headers = {"Authorization": "Bearer $token"};
      response = await dio.put(
        '${ServerConfig.changeOrderStatus}/$OrderID',
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final signUpResponse = response.data;
        Debug.log(signUpResponse);
        // Toaster.showToast(signUpResponse['message']);
        return signUpResponse;
      } catch (e) {
        Debug.log(e);
        return null;
      }
    } else {
      return null;
    }
  }


  static Future<Map<String, dynamic>?> updateUserServices(Map<String, dynamic> data, ID) async {
    Response response;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      Debug.log( '${ServerConfig.updateUserService}/service/$ID' + data.toString());
      final headers = {"Authorization": "Bearer $token"};
      response = await dio.put(
        '${ServerConfig.updateUserService}/service/$ID',
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final signUpResponse = response.data;
        Debug.log(signUpResponse);
        Toaster.showToast(signUpResponse['message']);
        return signUpResponse;
      } catch (e) {
        Debug.log(e);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<PaymentModel?> getPaymentInformation() async {
    Response response;
    PaymentModel? userPayment;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      String url = ServerConfig.getPaymentInformation;
      Debug.log(url);
      final headers = {
        "Authorization": "Bearer $token",
      };
      response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
    } catch (e, s) {
      Debug.log('Error fetching user profile: $e');
      Debug.log(s);
      return userPayment;
    }
    if (response.statusCode == 200) {
      try {
        final userProfileResponse = PaymentModel.fromJson(response.data);
        Debug.log(response.data);
        userPayment = userProfileResponse;
      } catch (e, s) {
        Debug.log('Error parsing user profile response: $e');
        Debug.log(s);
      }
    }
    return userPayment;
  }

  static Future<Map<String, dynamic>?> addUserFeedBack(Map<String, dynamic> data, orderID) async {
    Response response;
    try {
      String token = Get.find<Preferences>().getString(Keys.isToken) ?? "";
      Debug.log( '${ServerConfig.addUserFeedBack}/$orderID' + data.toString());
      final headers = {"Authorization": "Bearer $token"};
      response = await dio.put(
        '${ServerConfig.addUserFeedBack}/$orderID',
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      Debug.log(e);
      return null;
    }
    if (response.statusCode == 200) {
      Debug.log(response.data.toString());
      try {
        final signUpResponse = response.data;
        Debug.log(signUpResponse);
        Toaster.showToast(signUpResponse['message']);
        return signUpResponse;
      } catch (e) {
        Debug.log(e);
        return null;
      }
    } else {
      return null;
    }
  }
}
