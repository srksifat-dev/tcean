import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tcean/dummy/dummy_order.dart';
import 'package:tcean/features/explore/widgets/image_slider.dart';
import 'package:tcean/features/order_tracking/widgets/order_item_card.dart';
import 'package:tcean/features/order_tracking/widgets/order_item_slider.dart';
import 'package:tcean/models/user.dart';
import 'package:tcean/models/order_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/order_status.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({
    Key? key,
    required this.orderID,
  }) : super(key: key);
  final String orderID;

  @override
  Widget build(BuildContext context) {
    Order order =
        dummyOrders.where((element) => element.orderID == orderID).first;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          order.orderID,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            orderItemSlider(
                orderItemCards: order.carts
                    .map((e) => orderItemCard(context: context, cart: e))
                    .toList()),
            16.heightBox,

            // TODO: Receiver info

            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Receiver Info",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.percentWidth * 30,
                        child: Text("Name"),
                      ),
                      Expanded(child: Text(": ${dummyAccount.name}")),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.percentWidth * 30,
                        child: Text("Contact No."),
                      ),
                      Expanded(child: Text(": ${dummyAccount.phoneNumber}")),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.percentWidth * 30,
                        child: Text("Email"),
                      ),
                      Expanded(
                          child: Text(
                        ": ${dummyAccount.email}",
                      )),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.percentWidth * 30,
                        child: Text("Address"),
                      ),
                      Expanded(
                          child: Text(
                              ": ${dummyAccount.addresses!.first.detailsAddress}, ${dummyAccount.addresses!.first.area}, ${dummyAccount.addresses!.first.district}")),
                    ],
                  ),
                ],
              ).p(16),
            ),

            // TODO: Order status
            
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Status",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  OrderStatus(
                    index: 0,
                    asset: Lottie.asset("assets/lotties/confirmation.json"),
                    orderStatus: "Confirmed",
                    orderStatusColor: order.orderStep == OrderStep.confirmed
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    orderTime: order.orderStep == OrderStep.confirmed
                        ? order.orderTime.toString()
                        : "",
                    orderTimeColor: order.orderStep == OrderStep.confirmed
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    assetDelayTime: 100,
                    childDelayTime: 300,
                  ),
                  OrderStatus(
                    index: 1,
                    asset: order.orderStep == OrderStep.packed
                        ? Lottie.asset("assets/lotties/packed.json")
                        : Image.asset(
                            "assets/images/packed-grey.png",
                            height: context.percentWidth * 8,
                          ),
                    orderStatus: "Packed",
                    orderStatusColor: order.orderStep == OrderStep.packed
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    orderTime: order.orderStep == OrderStep.packed
                        ? order.orderTime.toString()
                        : "",
                    orderTimeColor: order.orderStep == OrderStep.packed
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    assetDelayTime: 200,
                    childDelayTime: 400,
                  ),
                  OrderStatus(
                    index: 2,
                    asset: order.orderStep == OrderStep.shipped
                        ? Lottie.asset("assets/lotties/shipped.json")
                        : Image.asset(
                            "assets/images/shipped-grey.png",
                            height: context.percentWidth * 6,
                          ),
                    orderStatus: "Shipped",
                    orderStatusColor: order.orderStep == OrderStep.shipped
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    orderTime: order.orderStep == OrderStep.shipped
                        ? order.orderTime.toString()
                        : "",
                    orderTimeColor: order.orderStep == OrderStep.shipped
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    assetDelayTime: 300,
                    childDelayTime: 500,
                  ),
                  order.deliveryMethod == DeliveryMethod.cod
                      ? OrderStatus(
                          index: 3,
                          asset: order.orderStep == OrderStep.delivered
                              ? Lottie.asset("assets/lotties/delivered.json")
                              : Image.asset(
                                  "assets/images/delivered-grey.png",
                                  height: context.percentWidth * 8,
                                ),
                          orderStatus: "Delivered",
                          orderStatusColor: order.orderStep ==
                                  OrderStep.delivered
                              ? Theme.of(context).colorScheme.onBackground
                              : Theme.of(context).colorScheme.surfaceVariant,
                          orderTime: order.orderStep == OrderStep.delivered
                              ? order.orderTime.toString()
                              : "",
                          orderTimeColor: order.orderStep == OrderStep.delivered
                              ? Theme.of(context).colorScheme.onBackground
                              : Theme.of(context).colorScheme.surfaceVariant,
                          assetDelayTime: 500,
                          childDelayTime: 700,
                        )
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                ],
              ).p(16),
            ),
          ],
        ).px(16),
      ),
    );
  }
}
