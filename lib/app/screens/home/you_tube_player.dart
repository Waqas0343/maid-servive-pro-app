import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:go_maids_pro/app/screens/app_common_widget/custom_card.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../routes/app_routes.dart';

class YouTubePlayerWidget extends StatefulWidget {
  final String videoId;

  const YouTubePlayerWidget({Key? key, required this.videoId})
      : super(key: key);

  @override
  State<YouTubePlayerWidget> createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget> {
  late YoutubePlayerController _controller;
  late bool _isPlaying;
  late bool _isBuffering;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        disableDragSeek: true,
        showLiveFullscreenButton: true,
        mute: false,
        forceHD: false,
      ),
    );
    _isPlaying = false;
    _isBuffering = true; // Initially, assume buffering
    _controller.addListener(_videoPlayerListener);
  }

  void _videoPlayerListener() {
    if (_controller.value.playerState == PlayerState.playing) {
      setState(() {
        _isPlaying = true;
        _isBuffering = false;
      });
    } else if (_controller.value.playerState == PlayerState.buffering) {
      setState(() {
        _isBuffering = true;
      });
    } else {
      setState(() {
        _isPlaying = false;
        _isBuffering = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.6,
      child: CustomCard(
        onPressed: () => Get.toNamed(
          AppRoutes.openVideoInFullScreen,
          arguments: widget.videoId,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: YoutubePlayerBuilder(
            onEnterFullScreen: (){
              Get.toNamed(
                AppRoutes.openVideoInFullScreen,
                arguments: widget.videoId,
              );
            },
            player: YoutubePlayer(
              controller: _controller,
              aspectRatio: 16 / 7,
              progressIndicatorColor: Colors.red,
              progressColors: ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.red,
              ),
              onReady: () {
                _controller.pause();
              },

            ),
            builder: (context, player) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  player,
                  if (_isBuffering)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 20,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPlaying
                                ? _controller.pause()
                                : _controller.play();
                            _isPlaying = !_isPlaying;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.fullscreen,
                          size: 20,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.openVideoInFullScreen,
                            arguments: widget.videoId,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
