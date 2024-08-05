import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Banners extends StatelessWidget {
  const Banners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxInt current = RxInt(0);
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            onPageChanged: (index, reason) {
              current(index);
            },
            aspectRatio: 16 / 8,
            autoPlayInterval: const Duration(seconds: 16),
            autoPlayAnimationDuration: const Duration(seconds: 3),
            viewportFraction: 1.0,
          ),
          items: images
              .map((imagePath) => GestureDetector(
            child: Image.asset(
              imagePath,
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ))
              .toList(),
        ),
      ],
    );
  }

  List<String> get images => [
    'assets/images/banners/super-app.png',
    'assets/images/banners/banner4.png',
    'assets/images/banners/banner3.png',
  ];
}