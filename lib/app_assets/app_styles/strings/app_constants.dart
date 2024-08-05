class Keys {
  static const String userId = "userID";
  static const String userName = "userName";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String name = "name";
  static const String email = "email";
  static const String dob = "DOB";
  static const String userImage = "userImage";
  static const String fullName  = "fullName";
  static const String isProfileComplete = "isProfileComplete";
  static const String isProfileImage = "isProfileImage";
  static const String isToken = "isToken";
  static const String isPhoneNumber = "Phone";
  static const String isFirstTime = "FirstTime";
  static const String rememberMe = "Remember Me";
  static const String password = "Password";
  static const String status = "FirstTime";
  static const String cryptoKey = "fMhBu#\$%be\$5eK!1ULX06z*iB4Nv03E1";
  static const String dateFormat = "yyyy-MM-dd";
  static const String timeFormat = "hh:mm a";
  // static const String timeFormat = "HH:mm";

  static const String imageNotFound = "https://instacare.pk/assets/img/Image-not-found.jpg";
  static const String versionNo = "VERSION V.1.1.2.0";


  static String getFormattedTime({required String time}) {
    int hour = int.parse(time.split(':')[0].toString());
    String hourZero = '';

    String minute = time.split(':')[1].toString();

    String isAmOrPm = 'AM';

    if (hour > 12) {
      hour = hour - 12;
      isAmOrPm = 'PM';
    } else if (hour == 00) {
      hour = 12;
    } else if (hour == 12) {
      isAmOrPm = 'PM';
    }

    if (minute == '0') {
      minute = '00';
    }

    if (hour < 10) {
      hourZero = '0';
    }

    return '${hourZero.toString()}${hour.toString()}:${minute.toString()} $isAmOrPm';
  }

  static String getFormattedTime2({required String time}) {
    int hour = int.parse(time.split(':')[0].toString());
    String hourZero = '';

    String minute = time.split(':')[1].toString();

    String isAmOrPm = 'AM';

    if (hour > 12) {
      hour = hour - 12;
      isAmOrPm = 'PM';
    } else if (hour == 00) {
      hour = 12;
    } else if (hour == 12) {
      isAmOrPm = 'PM';
    }

    if (minute == '0') {
      minute = '00';
    }

    if (hour < 10) {
      hourZero = '0';
    }

    return '${hourZero.toString()}${hour.toString()}:${minute.toString()}:00 $isAmOrPm';
  }
}
