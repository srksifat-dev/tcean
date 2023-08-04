import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget orderItemSlider({required  List<Widget> orderItemCards}) {
  return CarouselSlider(
    options: CarouselOptions(
      viewportFraction: 1,
      aspectRatio: 3,
      autoPlay: true,
    ),
    items: orderItemCards,
  );
}