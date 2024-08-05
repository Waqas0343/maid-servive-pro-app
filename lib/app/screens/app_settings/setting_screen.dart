import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/screens/app_settings/setting_screen_controller.dart';

import '../../../app_assets/app_styles/my_colors.dart';
import '../../../app_assets/app_styles/my_icons.dart';
import '../../routes/app_routes.dart';
import '../../services/preferences.dart';
import '../app_common_widget/app_dialog_confirmation.dart';
import '../app_common_widget/custom_card.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          CustomCard(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundColor: MyColors.greenAccentColor,
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      )),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userName,
                        style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(controller.email),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          CustomCard(
            child: Column(
              children: [
                ListTile(
                  onTap: () => Get.toNamed(AppRoutes.paymentsScreen),
                  leading: CircleAvatar(
                      backgroundColor: MyColors.greenAccentColor,
                      child: Icon(
                        Icons.payment,
                        color: Colors.white,
                      )),
                  title: Text("Payment Method"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
                ),
                Divider(
                  color: MyColors.primaryColor,
                ),
                ListTile(
                  onTap: () => Get.toNamed(AppRoutes.walletScreen),
                  leading: CircleAvatar(
                      backgroundColor: MyColors.greenAccentColor,
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                      )),
                  title: Text("Wallet"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          CustomCard(
            child: Column(
              children: [
                ListTile(
                  onTap: () => Get.toNamed(AppRoutes.myOrderScreen),
                  leading: CircleAvatar(
                      backgroundColor: MyColors.greenAccentColor,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      )),
                  title: Text("My Order"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
                ),
                Divider(
                  color: MyColors.primaryColor,
                ),
                ListTile(
                  onTap: () => Get.toNamed(AppRoutes.myAccount),
                  leading: CircleAvatar(
                      backgroundColor: MyColors.greenAccentColor,
                      child: Icon(
                        Icons.key_sharp,
                        color: Colors.white,
                      )),
                  title: Text("My Account"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          CustomCard(
            child: Column(
              children: [
                ListTile(
                  onTap: () => Get.toNamed(AppRoutes.contactUsScreen),
                  leading: CircleAvatar(
                    backgroundColor: MyColors.greenAccentColor,
                    child: Icon(Icons.phone, color: Colors.white,)
                  ),
                  title: Text("Contact Us"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
                ),
                Divider(
                  color: MyColors.primaryColor,
                ),
                ListTile(
                  onTap: () => Get.toNamed(AppRoutes.aboutUsScreen),
                  leading: CircleAvatar(
                      backgroundColor: MyColors.greenAccentColor,
                      child: Icon(
                        Icons.account_box_outlined,
                        color: Colors.white,
                      )),
                  title: Text("About"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          CustomCard(
            child: Column(
              children: [
                ListTile(
                  onTap: () => Get.toNamed(AppRoutes.disputeScreen),
                  leading: CircleAvatar(
                      backgroundColor: MyColors.greenAccentColor,
                      child: Icon(
                        Icons.warning,
                        color: Colors.white,
                      )),
                  title: Text("Disputes"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
                ),
                Divider(
                  color: MyColors.primaryColor,
                ),
                ListTile(
                  onTap: () {
                    ConfirmationAlert.showDialog(
                      title: "Confirmation",
                      description:
                          "Are you sure you want to log out of this app?",
                      onConfirm: () {
                        Get.find<Preferences>().logout();
                      },
                    );
                  },
                  leading: CircleAvatar(
                      backgroundColor: MyColors.greenAccentColor,
                      child: Icon(
                        Icons.logout,
                        color: Colors.white,
                      )),
                  title: Text("Logout"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
