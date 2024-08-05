import 'package:get/get.dart';
import 'package:go_maids_pro/app/services/preferences.dart';
class Services {
  static final Services _instance = Services._();
  Services._();
  factory Services() => _instance;
  Future<void> initServices() async {
    await Get.putAsync<Preferences>(() => Preferences().initial());
  }
}
