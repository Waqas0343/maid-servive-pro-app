import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/routes/app_routes.dart';
import 'package:go_maids_pro/app_assets/app_styles/my_colors.dart';
import '../app_common_widget/custom_card.dart';
import '../app_common_widget/igp_list_shimmer.dart';
import '../my_Orders/models/user_Order_model.dart';
import 'my_wallet_screen_controller.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyWalletScreenController controller =
        Get.put(MyWalletScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text("MY Wallet"),
      ),
      body: Obx(
        () => Column(
          children: [
            Container(
              height: 150, // Set the desired height of the card
              child: CustomCard(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: "Total Income: ",
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: MyColors.greenAccentColor,
                          ),
                          children: [
                            TextSpan(
                              text: "",
                              style: Get.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      // Add spacing between text elements
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: "In Progress: ",
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: MyColors.greenAccentColor,
                          ),
                          children: [
                            TextSpan(
                              text: "",
                              style: Get.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: "Pending:",
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: MyColors.greenAccentColor,
                          ),
                          children: [
                            TextSpan(
                              text: "",
                              style: Get.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: "Balance:",
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: MyColors.greenAccentColor,
                          ),
                          children: [
                            TextSpan(
                              text: "",
                              style: Get.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Add other ListTile properties
                ),
              ),
            ),
            Text("Order Summary",    style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16)),
            if (controller.userOrderList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  itemBuilder: (_, int index) {
                    Color backgroundColor = index % 2 == 0
                        ? Colors.white
                        : const Color(
                            0xffe5f7f1,
                          );
                    UserOrderListModel walletModel =
                        controller.userOrderList[index];
                    return Container(
                      height: 150, // Set the desired height of the card
                      child: CustomCard(
                        color: backgroundColor,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: "Date: ",
                                  style: Get.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.greenAccentColor,
                                  ),
                                  children: [
                                    TextSpan(

                                      text: controller.dateFormat.format(DateTime.parse( walletModel.orderDate.toString())),
                                      style: Get.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 6),
                              // Add spacing between text elements
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: "Order Key: ",
                                  style: Get.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.greenAccentColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "${walletModel.orderKey}",
                                      style: Get.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 6),
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: "Amount: ",
                                  style: Get.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.greenAccentColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "${walletModel.cost}",
                                      style: Get.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.viewWalletOrderSummary,
                                  arguments: walletModel);
                            },
                            child: Text('View Order'),
                          ),
                          // Add other ListTile properties
                        ),
                      ),
                    );
                  },
                  itemCount: controller.userOrderList.length,
                ),
              ),
            if (controller.userOrderList.isEmpty && controller.isLoading.value)
              Expanded(
                child: AllNotificationsShimmer(),
              ),
            if (!controller.isLoading.value && controller.userOrderList.isEmpty)
              Expanded(
                child: Center(
                  child: Text("No Booked Orders"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
