import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/spacing.dart';
import '../app_common_widget/custom_card.dart';
import 'models/get_user_dispute_model.dart';

class ViewDisputeDetailScreen extends StatelessWidget {
  const ViewDisputeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final disputeSummaryModel = Get.arguments as UserDisputeDataListModel;
    final DateFormat dateFormat = DateFormat(Keys.dateFormat);
    String getStatusText(String status) {
      switch (int.parse(status)) {
        case 0:
          return "Pending";
        case 1:
          return "Accepted";
        case 2:
          return "Completed";
        case 3:
          return "Cancelled";
        default:
          return "Unknown";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("View Dispute Detail"),
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
                    "Order# ${disputeSummaryModel.order.orderKey}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text:
                              "Order# ${disputeSummaryModel.order.orderKey}"));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Order copied to clipboard"),
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  dense: true,
                  minLeadingWidth: 0,
                  minVerticalPadding: 0,
                  horizontalTitleGap: 0,
                  title: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "Dispute Title: ",
                      style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "${disputeSummaryModel.title}",
                          style: Get.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  subtitle: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "Dispute Description: ",
                      style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "${disputeSummaryModel.description}",
                          style: Get.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),

                widgetSpacerVertically(),
                const Divider(
                  thickness: 1,
                  color: Colors.black87,
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
                      'https://maid-service.tecrux.solutions/public/${disputeSummaryModel.user.image.toString()}',
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dispute Opened By',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${disputeSummaryModel.user.fname} ${disputeSummaryModel.user.lname}',
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(disputeSummaryModel.user.email),
                      Text(disputeSummaryModel.user.mobileNo),
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
                      'https://maid-service.tecrux.solutions/public/${disputeSummaryModel.userFor.image.toString()}',
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dispute Opened For',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${disputeSummaryModel.userFor.fname} ${disputeSummaryModel.userFor.lname}',
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(disputeSummaryModel.userFor.email),
                      Text(disputeSummaryModel.userFor.mobileNo),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: MyButton(
                //           text: 'View Profile',
                //           onTap: () {
                //             Get.toNamed(
                //               AppRoutes.viewServicesTakerProfile,
                //               arguments: disputeSummaryModel,
                //             );
                //           },
                //         ),
                //       ),
                //       SizedBox(width: 8.0),
                //       Expanded(
                //         child: MyButton(
                //           text: 'Message',
                //           onTap: () {
                //             // Handle message action
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
                widgetSpacerVertically(),
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
                            text:
                            dateFormat.format(DateTime.parse(  disputeSummaryModel.order.orderDate.toString())),
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
                            text: disputeSummaryModel.order.slotStartTime
                                .toString(),
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
                            text: disputeSummaryModel.order.slotEndTime
                                .toString(),
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
                            text: disputeSummaryModel.order.selectedService
                                .toString(),
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
                            text: disputeSummaryModel.order.serviceAddress
                                .toString(),
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
                            text: disputeSummaryModel.order.billingAddress
                                .toString(),
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

                            text: '${getStatusText(disputeSummaryModel.order.status.toString())}',
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
                          "Cost Status",
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${disputeSummaryModel.order.cost}\$",
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
                          "App Commission",
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${disputeSummaryModel.order.appCommission}\$",
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
