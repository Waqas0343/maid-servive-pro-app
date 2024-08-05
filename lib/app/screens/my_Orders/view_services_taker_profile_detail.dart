import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'models/user_Order_model.dart';
import 'order_widget/user_profile_widget.dart';

class ViewServicesTakerProfile extends StatelessWidget {
  const ViewServicesTakerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final igpModel = Get.arguments as UserOrderListModel;
    double expandedHeight = 160;
    Set<Marker> markers = {};
    markers.add(
      Marker(
        markerId: MarkerId('UserLocation'),
        position: LatLng(
          double.tryParse(igpModel.serviceTaker.user.lat ?? '0') ?? 0.0,
          double.tryParse(igpModel.serviceTaker.user.lng ?? '0') ?? 0.0,
        ),
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: UserProfileWidget(
                expandedHeight: expandedHeight,
                user: igpModel,
              ),
              pinned: true,
              floating: false,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                    top: 130.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text(
                            'Phone No:',
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            igpModel.serviceTaker.user.mobileNo,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Default Address:',
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            igpModel.serviceAddress,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Country:',
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            igpModel.country,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Province:',
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            igpModel.city,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'City:',
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            igpModel.city,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Postal Code:',
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            igpModel.state,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'User Rating:',
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              Text(
                                igpModel.rating ?? '',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              RatingBarIndicator(
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 25.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: GoogleMap(
                        zoomControlsEnabled: true,
                        myLocationButtonEnabled: false,
                        zoomGesturesEnabled: true,
                        mapToolbarEnabled: false,
                        scrollGesturesEnabled: true,
                        compassEnabled: true,
                        gestureRecognizers: {}..add(
                            Factory<EagerGestureRecognizer>(
                              () => EagerGestureRecognizer(),
                            ),
                          ),
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.tryParse(
                                    igpModel.serviceTaker.user.lat ?? '0') ??
                                0.0,
                            double.tryParse(
                                    igpModel.serviceTaker.user.lng ?? '0') ??
                                0.0,
                          ),
                          zoom: 15.0,
                        ),
                        markers: markers,
                      ),
                    ),
                  ],
                );
              }, childCount: 1),
            ),
          ],
        ),
      ),
    );
  }
}
