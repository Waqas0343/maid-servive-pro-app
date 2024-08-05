import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_assets/app_styles/my_images.dart';
import '../../../../app_assets/app_styles/strings/app_constants.dart';
class ImageWithVideoIcon extends StatelessWidget {
  final String? imagePath;
  final bool isVideo;
  final double width, height;

  const ImageWithVideoIcon({
    Key? key,
    this.imagePath,
    this.isVideo = false,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          height: height,
          width: width,
          imageUrl: GetUtils.isNullOrBlank(imagePath)!
              ? Keys.imageNotFound
              : imagePath!,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                )
              ],
            ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage(MyImages.homePic),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                )
              ],
            ),
          ),
          placeholder: (_, __) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage(MyImages.homePic),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}