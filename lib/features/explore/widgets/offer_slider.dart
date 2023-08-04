import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tcean/features/explore/widgets/coupon_details.dart';
import 'package:tcean/models/coupon_model.dart';
import 'package:velocity_x/velocity_x.dart';

Widget offerSlider(BuildContext context, List<CouponModel> items) {
  return CarouselSlider(
      items: items
          .map((e) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16)),
                      child: Icon(
                        couponIcon(e),
                        size: 50,
                      ),
                    ),
                    16.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.couponName,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            couponDetails(coupon: e),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    // IconButton(
                    //     onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                  ],
                ).pOnly(left: 16, top: 16, bottom: 16),
              ))
          .toList(),
      options: CarouselOptions(
          viewportFraction: 1,
          aspectRatio: 3,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),),);
}
