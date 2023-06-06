import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/common/custom_textField.dart';
import 'package:tcean/common/editable_card.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../dummy/dummy_order.dart';
import '../../../models/account.dart';
import '../../../models/order.dart';
import '../../../routes/route_const.dart';
import '../../order_tracking/widgets/order_item_card.dart';
import '../../order_tracking/widgets/order_item_slider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    Key? key,
    required this.orderID,
  }) : super(key: key);
  final String orderID;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController couponController = TextEditingController();
  FocusNode couponFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    int total = 500;
    Order order =
        dummyOrders.where((element) => element.orderID == widget.orderID).first;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Todo: All ordered products
                Text("Ordered Products"),
                orderItemSlider(
                    orderItemCards: order.carts
                        .map((e) => orderItemCard(context: context, cart: e))
                        .toList()),
                16.heightBox,

                //TODO: Receiver info
                Text("Receiver Information"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    editableCard(
                        context: context,
                        subtitle: "${dummyAccount.name}",
                        icon: Icons.edit,
                        onTap: () {}),
                    editableCard(
                        context: context,
                        subtitle: "${dummyAccount.phoneNumber}",
                        icon: Icons.edit,
                        onTap: () {}),
                    editableCard(
                        context: context,
                        subtitle: "${dummyAccount.email}",
                        icon: Icons.edit,
                        onTap: () {}),
                    editableCard(
                        context: context,
                        title: "Delivery Method",
                        icon: Icons.edit,
                        onTap: () {}),
                    editableCard(
                        context: context,
                        title: "Address",
                        subtitle:
                            "${dummyAccount.addresses!.first.detailsAddress}, ${dummyAccount.addresses!.first.area}, ${dummyAccount.addresses!.first.district}",
                        icon: Icons.edit,
                        onTap: () {}),
                  ],
                ),
                16.heightBox,

                //TODO: Discount

                Text("Discount"),
                kTextField(
                  context: context,
                  controller: couponController,
                  focusNode: couponFocusNode,
                  hintText: "Enter Coupon Code",
                  maxLength: 6,
                  textInputType: TextInputType.text,
                ),
                16.heightBox,

                //TODO: Calculator
                Text("Total Payment"),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Product Expense:"),
                          Text("৳ $total"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Expense:"),
                          Text("৳ $total"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Discount:"),
                          Text("- ৳ $total"),
                        ],
                      ),
                    ],
                  ).p(16),
                )
              ],
            ),
          )),
          Container(
            height: 100,
            width: context.percentWidth * 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.onBackground),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Total : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                            ),
                            TextSpan(
                              text: total.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Pay now : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                            ),
                            TextSpan(
                              text: total.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Due : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                            ),
                            TextSpan(
                              text: total.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                    onPressed: () {
                      context.pushNamed(RouteConst.kPayment,
                            pathParameters: {
                              "orderID": dummyOrders.first.orderID
                            });
                    },
                    child: Text("Pay Now"))
              ],
            ).px(16),
          ),
        ],
      ).px(16),
    );
  }
}
