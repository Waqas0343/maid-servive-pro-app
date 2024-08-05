import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../app_assets/spacing.dart';
import '../../routes/app_routes.dart';
import '../app_common_widget/custom_card.dart';
import '../app_common_widget/my_button.dart';
import '../my_Orders/models/user_Order_model.dart';

class ViewWalletOrderSummary extends StatelessWidget {
  const ViewWalletOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final igpModel = Get.arguments as UserOrderListModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Summary"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    "Order# ${igpModel.orderKey}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: "Order# ${igpModel.orderKey}"));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Order copied to clipboard"),
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  minLeadingWidth: 0,
                  contentPadding: const EdgeInsets.only(left: 16.0),
                  horizontalTitleGap: 0,
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                      'https://maid-service.tecrux.solutions/public/${igpModel.serviceProvider.user.image.toString()}',
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Provider',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${igpModel.serviceProvider.user.fname} ${igpModel.serviceProvider.user.lname}',
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(igpModel.serviceProvider.user.email),
                      Text(igpModel.serviceProvider.user.mobileNo),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    // Handle customer tap
                  },
                  dense: true,
                  minLeadingWidth: 0,
                  contentPadding: const EdgeInsets.only(left: 16.0),
                  horizontalTitleGap: 0,
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                      'https://maid-service.tecrux.solutions/public/${igpModel.serviceTaker.user.image.toString()}',
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(igpModel.serviceTaker.user.username.toString()),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(igpModel.serviceTaker.user.email),
                      Text(igpModel.serviceTaker.user.mobileNo),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyButton(
                          text: 'View Profile',
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.viewServicesTakerProfile,
                              arguments: igpModel,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: MyButton(
                          text: 'Message',
                          onTap: () {
                            // Handle message action
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black87,
                ),
                Text(
                  'Order Summary:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "Date: ",
                        style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: igpModel.orderDate.toString(),
                            style: Get.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    widgetSpacerVertically(),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "Start Time: ",
                        style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: igpModel.slotStartTime.toString(),
                            style: Get.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    widgetSpacerVertically(),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "End Time: ",
                        style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: igpModel.slotEndTime.toString(),
                            style: Get.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    widgetSpacerVertically(),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "Services Name: ",
                        style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: igpModel.selectedService.toString(),
                            style: Get.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    widgetSpacerVertically(),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "Services Address: ",
                        style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: igpModel.serviceAddress.toString(),
                            style: Get.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    widgetSpacerVertically(),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "Billing Address: ",
                        style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: igpModel.billingAddress.toString(),
                            style: Get.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    widgetSpacerVertically(),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "Order Status: ",
                        style: Get.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: igpModel.status.toString(),
                            style: Get.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                widgetSpacerVertically(),
                const Divider(
                  thickness: 1,
                  color: Colors.black87,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Per Hour Rate",
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${igpModel.cost}\$",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green, // Change color as needed
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Per Hour Rate",
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${igpModel.cost}\$",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green, // Change color as needed
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black87,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${igpModel.cost}\$",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green, // Change color as needed
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
