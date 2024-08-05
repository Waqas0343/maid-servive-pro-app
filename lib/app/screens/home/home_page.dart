import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/screens/app_common_widget/custom_card.dart';
import '../../../app_assets/app_styles/my_icons.dart';
import '../../../app_assets/app_styles/my_images.dart';
import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/spacing.dart';
import '../../routes/app_routes.dart';
import '../../services/preferences.dart';
import '../app_common_widget/app_dialog_confirmation.dart';
import '../app_common_widget/home_card_widget.dart';
import '../app_common_widget/tool_widget.dart';
import 'banners.dart';
import 'home_controller.dart';
import 'home_widget/video_frame.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        key: controller.drawerKey,
        titleSpacing: 0,
        elevation: 0,
        centerTitle: false,
        title: Center(
          child: Image.asset(
            MyImages.logo,
            color: Colors.white,
            height: 80.0,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const Banners(),
          widgetSpacerVertically(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: "${controller.greeting} ",
                style: Get.textTheme.titleSmall,
                children: [
                  TextSpan(
                    text: "${controller.userName}",
                    style: Get.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 2,
          ),
          widgetSpacerVertically(),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            margin: EdgeInsets.zero,
            child: Row(
              children: [
                Expanded(
                  child: HomeCardWidget(
                    onTap: () {
                      Get.toNamed(AppRoutes.myAccount);
                    },
                    title: "My Account",
                    assetPath: "assets/account.png",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: HomeCardWidget(
                    onTap: () {
                      Get.toNamed(AppRoutes.myOrderScreen);
                    },
                    title: "My Order",
                    assetPath: "assets/myOrder.jpg",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: HomeCardWidget(
                    onTap: () {
                      Get.toNamed(AppRoutes.disputeScreen);
                    },
                    title: "Disputes",
                    assetPath: "assets/disput.jpg",
                  ),
                ),
              ],
            ),
          ),
          widgetSpacerVertically(),
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ToolsWidget(
                        title: "Notification",
                        icon: MyIcons.isNotification,
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.notificationScreen,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                widgetSpacerHorizontally(),
                Expanded(
                  child: ToolsWidget(
                    title: "Payment",
                    icon: MyIcons.isPayment,
                    onTap: () {
                      Get.toNamed(AppRoutes.paymentsScreen);
                    },
                  ),
                ),
                widgetSpacerHorizontally(),
                Expanded(
                  child: ToolsWidget(
                    title: "Wallet",
                    icon: MyIcons.isWallet,
                    onTap: () {
                      Get.toNamed(AppRoutes.walletScreen);
                    },
                  ),
                )
              ],
            ),
          ),
          widgetSpacerVertically(),
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            margin: EdgeInsets.zero,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ToolsWidget(
                    title: "Message",
                    icon: MyIcons.isMessage,
                    onTap: () {
                      Get.toNamed(AppRoutes.messagesScreen);
                    },
                  ),
                ),
                widgetSpacerHorizontally(),
                Expanded(
                  child: ToolsWidget(
                    title: "Logout",
                    icon: MyIcons.isLogout,
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
                  ),
                ),
                widgetSpacerHorizontally(),
                Expanded(child: Text('')),
              ],
            ),
          ),
          const Divider(
            thickness: 5,
          ),
          YouTube(),
          widgetSpacerVertically(),
          Obx(() {
            if (controller.userStatus.value == null) {
              return SizedBox.shrink();
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF307cec).withOpacity(0.4),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8.0),
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.account_circle,
                                color: Colors.white,
                                size: 24),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Status',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Check your current status here',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      StatusItem(
                        title: 'Your Star Rating:',
                        value: controller.userStatus.value!.data.rating
                                ?.toString() ??
                            '0',
                      ),
                      StatusItem(
                        title: 'Money Earned:',
                        value:
                            '\$${controller.userStatus.value!.data.netIncome}',
                      ),
                      StatusItem(
                        title: 'Total Orders:',
                        value: controller.userStatus.value!.data.totalOrders
                            .toString(),
                      ),
                      StatusItem(
                        title: 'Pending Orders:',
                        value: controller.userStatus.value!.data.pendingOrders
                            .toString(),
                      ),
                      StatusItem(
                        title: 'Completed Orders:',
                        value: controller.userStatus.value!.data.completedOrders
                            .toString(),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
          widgetSpacerVertically(),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 34,
            ),
            child: Column(
              children: [
                Text(
                  Keys.versionNo,
                  style: Get.textTheme.bodySmall,
                ),
                Text(
                  "Copyrights Ⓒ Gomaids (Private) Limited.\n"
                  "Gomaids Head Office, 127 Westmore Dr\n"
                  "Unit 119 Etobicoke, ON M9V 3Y6 Canda\n"
                  "All rights are reserved.\n",
                  style: Get.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Image.asset(
              'assets/images/gomaids.png',
              height: 80,
              width: 80,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF3F51B5), Color(0xFF303F9F)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.7),
            onTap: controller.onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            iconSize: 24,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class StatusItem extends StatelessWidget {
  final String title;
  final String value;

  const StatusItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Get.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
