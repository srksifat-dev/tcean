import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tcean/core/common/main_appBar.dart';
import 'package:tcean/dummy/dummy_order.dart';
import 'package:tcean/dummy/dummy_product.dart';
import 'package:tcean/features/cart/widgets/cart_card.dart';
import 'package:tcean/models/cart.dart';
import 'package:tcean/core/constants/route_const.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../dummy/dummy_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int deliveryCharge = 60;
  int total = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context: context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          carts.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var cart = carts[index];
                      return Dismissible(
                        key: ValueKey(carts[index].product.productID),
                        background: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          color: Theme.of(context).colorScheme.error,
                        ),
                        onDismissed: (_) {
                          setState(() {
                            carts.remove(carts[index]);
                          });
                        },
                        child: cartCard(context: context, cart: cart),
                      );
                    },
                    separatorBuilder: (_, __) => 16.heightBox,
                    itemCount: carts.length,
                  ),
                )
              : Expanded(
                  child: Center(
                      child: Lottie.asset("assets/lotties/empty_cart.json")),
                ),
          AnimatedContainer(
            height: carts.isEmpty ? 0 : 80,
            width: context.percentWidth * 100,
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.onBackground),
            child: Visibility(
              maintainState: true,
              maintainAnimation: true,
              visible: carts.isEmpty ? false : true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Total Product Expense: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
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
                  ),
                  FilledButton(
                      onPressed: () {
                        context.pushNamed(RouteConst.kCheckout,
                            pathParameters: {
                              "orderID": dummyOrders.first.orderID
                            });
                      },
                      child: Text("Check Out"))
                ],
              ).px(16),
            ),
          ),
        ],
      ).px(16),
    );
  }
}
