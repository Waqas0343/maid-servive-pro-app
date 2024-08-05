import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../app_assets/app_styles/my_colors.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
import '../../../../app_assets/app_styles/text_styles/text_styles.dart';
import '../../../../app_assets/vertical_divider.dart';
import '../models/user_Order_model.dart';
import 'order_user_image_widget.dart';

class UserProfileWidget extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final UserOrderListModel? user;
  UserProfileWidget({
    required this.expandedHeight,
    required this.user,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final DateFormat dateFormat = DateFormat(Keys.dateFormat);
    final DateFormat timeFormat = DateFormat(Keys.timeFormat);
    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        Container(
          color: MyColors.primaryColor,
        ),
        AppBar(
          centerTitle: true,
          title: Opacity(
              opacity: shrinkOffset / expandedHeight,
              child: Text('${user?.serviceTaker.user.fname} ${user?.serviceTaker.user.lname}',)),
        ),
        Positioned(
          top: expandedHeight / 3.0 - shrinkOffset,
          width: Get.width,
          height: Get.height,
          child: Opacity(
            opacity: 1 - shrinkOffset / expandedHeight,
            child: Stack(
              children: [
                Positioned(
                  top: 50.0,
                  left: 14.0,
                  right: 14.0,
                  child: Card(
                    elevation: 2,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: MyTextStyle.height60,
                          ),
                          child: Column(
                            children: [
                              Text(
                                ' ${user?.serviceTaker.user.fname} ${user?.serviceTaker.user.lname}',
                                style: Get.textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                user!.serviceTaker.user.email,
                                // style: Get.theme.textTheme.bodyText2,
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: "Start\n",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        children: [
                                            TextSpan(
                                              text: timeFormat.format(DateTime.parse( user!.serviceTaker.user.createdAt.toString())),
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
                                        text: "DOB\n",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        children: [
                                          TextSpan(

                                            text: dateFormat.format(DateTime.parse( user!.serviceTaker.user.dob.toIso8601String())),
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
                                        text: "Profile Complete\n",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '${user!.serviceTaker.user.profileCompletion}%',
                                            style: MyTextStyle.styleSubTile2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  width: Get.width,
                  child: Center(
                    child: ImageWithVideoIcon(
                      imagePath:  'https://maid-service.tecrux.solutions/public/${user!.serviceTaker.user.image.toString()}',
                      width: MyTextStyle.height105,
                      height: MyTextStyle.height105,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}