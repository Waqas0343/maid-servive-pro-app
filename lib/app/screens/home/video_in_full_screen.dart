import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; // Import Get package
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreenVideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String videoId = Get.arguments;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );

    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          progressColors: ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.red,
          ),
          aspectRatio: 16 / 9,
          onReady: () {
            controller.play();
          },
        ),
      ),
    );
  }
}
