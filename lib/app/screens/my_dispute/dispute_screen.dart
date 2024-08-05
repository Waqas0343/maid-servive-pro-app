import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app/routes/app_routes.dart';
import 'package:go_maids_pro/app/screens/app_common_widget/custom_card.dart';
import '../../../app_assets/app_styles/my_colors.dart';
import '../app_common_widget/igp_list_shimmer.dart';
import 'controllers/dispute_screen_controller.dart';
import 'models/get_user_dispute_model.dart';

class DisputeScreen extends StatelessWidget {
  const DisputeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DisputeScreenController controller =
        Get.put(DisputeScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Check All Dispute"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(AppRoutes.createNewDispute, arguments: controller.orderList);
            },
          )

        ],
      ),
      body: Obx(
        () => Column(
          children: [
            if (controller.userDisputeList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4,
                  ),
                  itemBuilder: (_, int index) {
                    UserDisputeDataListModel igpModel = controller.userDisputeList[index];
                    Color backgroundColor = index % 2 == 0
                        ? Colors.white
                        : const Color(
                            0xffe5f7f1,
                          );
                    return CustomCard(
                      onPressed: ()=>Get.toNamed(AppRoutes.viewDisputeDetail,   arguments: igpModel),
                      color: backgroundColor,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: const CircleAvatar(
                          radius: 20.0,
                          backgroundColor: MyColors.primaryColor,
                          child: Icon(
                            Icons.call_received_outlined,
                            color: Colors.white,
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              igpModel.title.toString(),
                              style: Get.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              igpModel.description,
                            ),

                          ],
                        ),
                        subtitle: Text(
                          igpModel.status =='0' ? 'Resolved' :'Progress',
                          style: Get.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.red
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: controller.userDisputeList.length,
                ),
              ),
            if (controller.userDisputeList.isEmpty && controller.isLoading.value)
              const Expanded(
                child: AllNotificationsShimmer(),
              ),
            if (!controller.isLoading.value && controller.userDisputeList.isEmpty)
              const Expanded(
                child: Center(
                  child: Text("No Data Found..."),
                ),
              )
          ],
        ),
      ),
    );
  }
}
