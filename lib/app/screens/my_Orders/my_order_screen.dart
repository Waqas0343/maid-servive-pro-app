import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_assets/app_styles/text_styles/text_styles.dart';
import 'models/user_Order_model.dart';
import 'my_order_screen_controller.dart';
import 'order_widget/order_list_shimmer.dart';
import 'order_widget/order_list_widget.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyOrderScreenController controller = Get.put(MyOrderScreenController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.userOrderList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= controller.userOrderList.length) {
                      return Container(
                        height: MyTextStyle.height120 + MyTextStyle.height90,
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: const OrderListShimmer(
                          itemsCount: 1,
                        ),
                      );
                    }
                    UserOrderListModel doctorModel = controller.userOrderList[index];
                    return OrderWidget(
                      orderModel: doctorModel,
                    );
                  },
                  itemCount: controller.userOrderList.length,
                ),
              ),
            if (controller.userOrderList.isEmpty && controller.isLoading.value)
              Expanded(
                child: OrderListShimmer(
                  itemsCount: 3,
                ),
              ),
            if (controller.userOrderList.isEmpty && !controller.isLoading.value)
              const Expanded(
                child: Center(
                  child: Text("No Order Found"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
