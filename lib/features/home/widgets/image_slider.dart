import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final List<String> imgList = [
  'assets/images/tcean-01.svg',
  'assets/images/tcean-01.svg',
  'assets/images/tcean-01.svg',
  'assets/images/tcean-01.svg',
  'assets/images/tcean-01.svg',
];

Widget imgSlider() {
  return CarouselSlider(
    options: CarouselOptions(
      viewportFraction: 1,
      aspectRatio: 3,
      autoPlay: true,
    ),
    items: imgList
        .map((item) => Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SvgPicture.asset(
                item,
                fit: BoxFit.cover,
              ),
            )))
        .toList(),
  );
}

// class CustomImageSlider extends StatelessWidget with PreferredSizeWidget {
//   const CustomImageSlider({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return imgSlider();
//   }

//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => const Size.fromHeight(500);
// }
