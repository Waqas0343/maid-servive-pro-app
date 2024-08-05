import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/routes/app_routes.dart';
import 'package:intl/intl.dart';
import '../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../app_assets/spacing.dart';
import '../app_common_widget/custom_card.dart';
import '../app_common_widget/my_button.dart';
import 'models/user_Order_model.dart';
import 'my_order_screen_controller.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyOrderScreenController controller =
        Get.find<MyOrderScreenController>();
    final igpModel = Get.arguments as UserOrderListModel;
    final DateFormat dateFormat = DateFormat(Keys.dateFormat);
    final DateTime orderDate = DateTime.parse(igpModel.orderDate.toString());
    final List<String> slotEndTimeParts =
        igpModel.slotEndTime.toString().split(':');
    final int endHour = int.parse(slotEndTimeParts[0]);
    final int endMinute = int.parse(slotEndTimeParts[1]);
    final int endSecond = int.parse(slotEndTimeParts[2]);

    final DateTime slotEndTime = DateTime(
      orderDate.year,
      orderDate.month,
      orderDate.day,
      endHour,
      endMinute,
      endSecond,
    );
    final DateTime currentTime = DateTime.now();
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
        title: const Text("Order Summary"),
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
                            text: dateFormat.format(
                                DateTime.parse(igpModel.orderDate.toString())),
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
                            text: '${getStatusText(igpModel.status.value)}',
                            style: Get.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                widgetSpacerVertically(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Customer FeedBack',
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (igpModel.serviceTakerFeedback != null)
                          Text(
                            igpModel.serviceTakerFeedback,
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        igpModel.serviceTakerFeedback != null && igpModel.rating != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                    int.parse(igpModel.rating), (index) {
                                  return SizedBox(
                                    width: 30,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onPressed: () {},
                                    ),
                                  );
                                }),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(5, (index) {
                                  return SizedBox(
                                    width: 30,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.star_border_outlined,
                                        color: Colors.black12,
                                      ),
                                      onPressed: () {},
                                    ),
                                  );
                                }),
                              )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Services Provider Feedback',
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (igpModel.serviceProviderFeedback != null)
                          Text(
                            igpModel.serviceProviderFeedback,
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        igpModel.serviceProviderFeedback != null && igpModel.spRating != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(int.parse(igpModel.spRating), (index) {
                                  return SizedBox(
                                    width: 30,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onPressed: () {},
                                    ),
                                  );
                                }),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(5, (index) {
                                  return SizedBox(
                                    width: 30,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.star_border_outlined,
                                        color: Colors.black12,
                                      ),
                                      onPressed: () {},
                                    ),
                                  );
                                }),
                              ),
                      ],
                    ),
                  ],
                ),
                widgetSpacerVertically(),
                Text(
                  "Additional Notes",
                  style: Get.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
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
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black87,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    if (igpModel.spRating == null && igpModel.status == '2')
                      Expanded(
                        child: MyButton(
                          text: 'Rate',
                          onTap: () async {
                            Get.defaultDialog(
                                title: "Are you Satisfied",
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Give us quick rating so we know if you like it?',
                                      style: Get.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Obx(() {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(5, (index) {
                                          return IconButton(
                                            icon: Icon(
                                              index < controller.rating.value
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Colors.amber,
                                            ),
                                            onPressed: () =>
                                                controller.setRating(index + 1),
                                          );
                                        }),
                                      );
                                    }),
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      controller: controller.feedBackController,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        hintText: 'Write your feedback',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 45,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text('Close'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: MyButton(
                                            onTap: () {
                                              controller.addOrderFeedBack(
                                                  igpModel.id.toString());
                                            },
                                            text: 'Submit',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ));
                          },
                        ),
                      ),
                    SizedBox(
                      width: 8,
                    ),
                    if (currentTime.isAfter(slotEndTime) &&
                        igpModel.status != '3' &&
                        igpModel.status != '2')
                      Expanded(
                        child: MyButton(
                          text: 'Complete',
                          onTap: () async {
                            Get.defaultDialog(
                              title: 'Are you sure?',
                              content: Column(
                                children: [
                                  Icon(
                                    Icons.sd_card_alert_outlined,
                                    color: Colors.red,
                                    size: 50,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                      'Do you really want to complete this order? You will not be able to revert this action'),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('No'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.changeOrderStatusInSummaryPage(igpModel.id.toString());
                                  },
                                  child: Text("Yes, I'm Sure"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.red, // Background color
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
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
