import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tcean/core/common/error_text.dart';
import 'package:tcean/core/common/loader.dart';
import 'package:tcean/dummy/dummy_order.dart';
import 'package:tcean/features/order/controller/order_controller.dart';
import 'package:tcean/features/order/widgets/order_item_card.dart';
import 'package:tcean/features/order/widgets/order_item_slider.dart';
import 'package:tcean/models/order_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/order_status.dart';

class OrderDetailsScreen extends ConsumerWidget {
  OrderDetailsScreen({
    Key? key,
    required this.order,
    required this.orderID,
  }) : super(key: key);
  final OrderModel order;
  final String orderID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    OrderModel order =
        dummyOrders.where((element) => element.orderID == orderID).first;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          order.orderID,
        ),
      ),
      body: ref.watch(getCartsOfOrderProvider(orderID)).when(data: (carts) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            orderItemSlider(
                orderItemCards: carts
                    .map((e) => orderItemCard(context: context, cart: e))
                    .toList()),
            16.heightBox,

            // TODO: Receiver info
ref.watch(getReceiverAddressProvider(orderID)).when(data: (address) => Card(
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
                        child: const Text("Name"),
                      ),
                      Expanded(child: Text(": ${order.receiverName}")),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.percentWidth * 30,
                        child: const Text("Contact No."),
                      ),
                      Expanded(child: Text(": ${order.receiverContactNumber}")),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.percentWidth * 30,
                        child: const Text("Email"),
                      ),
                      Expanded(
                          child: Text(
                        ": ${order.receiverEmail}",
                      )),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.percentWidth * 30,
                        child: const Text("Address"),
                      ),
                      Expanded(
                          child: Text(
                              ": ${address.detailsAddress}, ${address.area}, ${address.district}")),
                    ],
                  ),
                ],
              ).p(16),
            ),error: (error, stackTrace) => ErrorText(error: error.toString()),loading: () => const Loader(),),
            

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
                    orderStatusColor: order.orderStatus == "confirmed"
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    orderTime: order.orderStatus == "confirmed"
                        ? order.orderTime.toString()
                        : "",
                    orderTimeColor: order.orderStatus == "confirmed"
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    assetDelayTime: 100,
                    childDelayTime: 300,
                  ),
                  OrderStatus(
                    index: 1,
                    asset: order.orderStatus == "packed"
                        ? Lottie.asset("assets/lotties/packed.json")
                        : Image.asset(
                            "assets/images/packed-grey.png",
                            height: context.percentWidth * 8,
                          ),
                    orderStatus: "Packed",
                    orderStatusColor: order.orderStatus == "packed"
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    orderTime: order.orderStatus == "packed"
                        ? order.orderTime.toString()
                        : "",
                    orderTimeColor: order.orderStatus == "packed"
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    assetDelayTime: 200,
                    childDelayTime: 400,
                  ),
                  OrderStatus(
                    index: 2,
                    asset: order.orderStatus == "shipped"
                        ? Lottie.asset("assets/lotties/shipped.json")
                        : Image.asset(
                            "assets/images/shipped-grey.png",
                            height: context.percentWidth * 6,
                          ),
                    orderStatus: "Shipped",
                    orderStatusColor: order.orderStatus == "shipped"
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    orderTime: order.orderStatus == "shipped"
                        ? order.orderTime.toString()
                        : "",
                    orderTimeColor: order.orderStatus == "shipped"
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.surfaceVariant,
                    assetDelayTime: 300,
                    childDelayTime: 500,
                  ),
                  order.deliveryMethod == "hd"
                      ? OrderStatus(
                          index: 3,
                          asset: order.orderStatus == "delivered"
                              ? Lottie.asset("assets/lotties/delivered.json")
                              : Image.asset(
                                  "assets/images/delivered-grey.png",
                                  height: context.percentWidth * 8,
                                ),
                          orderStatus: "Delivered",
                          orderStatusColor: order.orderStatus ==
                                  "delivered"
                              ? Theme.of(context).colorScheme.onBackground
                              : Theme.of(context).colorScheme.surfaceVariant,
                          orderTime: order.orderStatus == "delivered"
                              ? order.orderTime.toString()
                              : "",
                          orderTimeColor: order.orderStatus == "delivered"
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
      ),error: (error, stackTrace) => ErrorText(error: error.toString()),loading: () => const Loader(),)
      
    );
  }
}
