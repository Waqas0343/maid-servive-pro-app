import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/routes/app_routes.dart';
import 'package:go_maids_pro/app/screens/app_common_widget/custom_card.dart';
import 'package:go_maids_pro/app_assets/app_styles/my_colors.dart';
import '../../../app_assets/app_styles/my_icons.dart';
import 'controllers/my_account_screen_controller.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountScreenController controller = Get.put(AccountScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text("My Accounts"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          CustomCard(
            child: Column(
              children: [
                ListTile(
                  onTap: ()=> Get.toNamed(AppRoutes.changePasswordScreen),
                  leading:  CircleAvatar(
                    backgroundColor: MyColors.primaryColor,
                    child: SvgPicture.asset(
                      MyIcons.changePassword,
                      color: Colors.white,
                      width: 24, // Adjust size as needed
                      height: 24,
                    ),
                  ),
                  title: Text("Change Password"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
                ),
                Divider(
                  color: MyColors.primaryColor,
                ),
                ListTile(
                  onTap: ()=> Get.toNamed(AppRoutes.userProfileScreen),
                  leading: CircleAvatar(
                    backgroundColor: MyColors.primaryColor,
                    child: SvgPicture.asset(
                      color: Colors.white,
                      MyIcons.userProfile,
                      width: 24, // Adjust size as needed
                      height: 24,
                    ),
                  ),
                  title: Text("User Profile"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          CustomCard(
            child: Column(
              children: [
                ListTile(
                  onTap: ()=> Get.toNamed(AppRoutes.userServicesScreen),
                  leading: CircleAvatar(
                    backgroundColor: MyColors.primaryColor,
                    child: SvgPicture.asset(
                      color: Colors.white,
                      MyIcons.userService,
                      width: 24, // Adjust size as needed
                      height: 24,
                    ),
                  ),
                  title: Text("User Service"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
                ),
                Divider(
                  color: MyColors.primaryColor,
                ),
                ListTile(
                  onTap: ()=> Get.toNamed(AppRoutes.userAvailabilityScreen),
                  leading: CircleAvatar(
                    backgroundColor: MyColors.primaryColor,
                    child: SvgPicture.asset(
                      color: Colors.white,
                      MyIcons.userAvailability,
                      width: 24, // Adjust size as needed
                      height: 24,
                    ),
                  ),
                  title: Text("Set Your Availability"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
