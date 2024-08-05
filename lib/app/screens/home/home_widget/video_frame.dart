import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_common_widget/app_title_widget.dart';
import '../home_controller.dart';
import '../you_tube_player.dart';

class YouTube extends StatelessWidget {
  const YouTube({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Column(
      children: [
        SizedBox(height: 16.0,),
        const TitleWidget(
          title: "Explainer Videos",
        ),
        SizedBox(height: 8.0,),
        AspectRatio(
          aspectRatio: 18 / 7,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 12.0),
              itemCount: controller.videos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: YouTubePlayerWidget(videoId: controller.videos[index]),
                );
              }),
        ),
      ],
    );
  }
}
