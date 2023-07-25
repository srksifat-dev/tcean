import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tcean/features/order_tracking/widgets/order_item_card.dart';
import 'package:tcean/models/order_model.dart';
import 'package:tcean/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemCarousel extends StatefulWidget {
  const ItemCarousel({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;

  @override
  _ItemCarouselState createState() => _ItemCarouselState();
}

class _ItemCarouselState extends State<ItemCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
              enlargeCenterPage: true,
              height: context.percentWidth * 25,
              autoPlay: true,
              enableInfiniteScroll: true,
              onPageChanged: (index, _) {
                setState(() {
                  _current = index;
                });
              }),
          itemCount: widget.order.carts.length,
          itemBuilder: (context, cartIndex, pageViewIndex) {
            return orderItemCard(
                context: context, cart: widget.order.carts[cartIndex]);
          },
        ),
        HeightBox(context.percentWidth * 2),
        SizedBox(
          height: context.percentWidth * 5,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.order.carts.map((e) {
              int index = widget.order.carts.indexOf(e);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(right: context.percentWidth * 1),
                height: 10,
                width: _current == index ? 30 : 10,
                decoration: BoxDecoration(
                    color: _current == index
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.onBackground,
                    borderRadius: BorderRadius.circular(5)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
