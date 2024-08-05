import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_assets/app_styles/text_styles/text_styles.dart';
import '../../../../app_assets/vertical_divider.dart';
import '../../../routes/app_routes.dart';
import '../../app_common_widget/custom_card.dart';
import '../../app_common_widget/my_button.dart';
import '../models/user_Order_model.dart';
import '../my_order_screen_controller.dart';
import 'order_user_image_widget.dart';

class OrderWidget extends StatelessWidget {
  final UserOrderListModel orderModel;
  final VoidCallback? onTap, showProfile;

  const OrderWidget({
    Key? key,
    required this.orderModel,
    this.onTap,
    this.showProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyOrderScreenController controller = Get.find<MyOrderScreenController>();
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
          return "Select";
      }
    }

    final String? profileImagePath = orderModel.serviceTaker.user.image.toString();
    final String profileImageUrl = 'https://maid-service.tecrux.solutions/public/$profileImagePath';
    return CustomCard(
      onPressed: showProfile,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.orderSummary,
                      arguments: orderModel,
                    );
                  },
                  leading: ImageWithVideoIcon(
                    imagePath: profileImageUrl,
                    width: 70,
                    height: 70,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(right: 80),
                    child: Text(
                      '${orderModel.serviceTaker.user.fname} ${orderModel.serviceTaker.user.lname}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${orderModel.serviceTaker.user.email}",
                        style: MyTextStyle.styleBodyText2,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Start Time\n",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: '${orderModel.slotStartTime}',
                              style: MyTextStyle.styleSubTile2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalDivider(),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "End Time\n",
                          style: MyTextStyle.styleBodyText2,
                          children: [
                            TextSpan(
                              text: '${orderModel.slotEndTime}',
                              style: MyTextStyle.styleSubTile2,
                            )
                          ],
                        ),
                      ),
                    ),
                    verticalDivider(),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Cost\n",
                          style: MyTextStyle.styleBodyText2,
                          children: [
                            TextSpan(
                              text: '${orderModel.cost}',
                              style: MyTextStyle.styleSubTile2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalDivider(),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Status\n',
                          style: MyTextStyle.styleBodyText2,
                          children: [
                            TextSpan(
                              text: '${getStatusText(orderModel.status.value)}',
                              style: MyTextStyle.styleSubTile2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (orderModel.status.value == '0') {
                  return Container(
                    decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Colors.blue)),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedValue.value,
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedValue.value = value;
                          controller.changeOrder(orderModel.id.toString());
                        }
                      },
                      items: controller.statusOptions.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(
                            status,
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).where((item) {
                        return !(orderModel.orderDate.isBefore(DateTime.now().add(Duration(days: 1))) && item.value == 'Completed');
                      }).toList(),
                      decoration: InputDecoration(
                        border: InputBorder.none, // Remove default border
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ), // Adjust content padding
                      ),
                    ),
                  );
                }
                return  SizedBox.shrink();
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  text: 'View',
                  onTap: () async {
                    Get.toNamed(
                      AppRoutes.orderSummary,
                      arguments: orderModel,
                    );
                  },
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    'Services Taker',
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
