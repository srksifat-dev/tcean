import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tcean/core/common/error_text.dart';
import 'package:tcean/core/common/loader.dart';
import 'package:tcean/core/common/main_appBar.dart';
import 'package:tcean/features/cart/controller/cart_controller.dart';
import 'package:tcean/features/cart/widgets/cart_card.dart';
import 'package:tcean/models/cart_model.dart';
import 'package:tcean/core/constants/route_const.dart';
import 'package:tcean/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  int deliveryCharge = 60;
  int total = 0;
  List<CartModel> carts = [];

  bool _isBackPressed = false;

  Future<bool> _onWillPop() async {
    if (_isBackPressed) {
      // If already pressed once, exit the app
      return true;
    }

    _isBackPressed = true;
    _showSnackBar('Press back again to exit');

    Timer(const Duration(seconds: 2), () {
      // Reset the flag after 2 seconds
      _isBackPressed = false;
    });

    return false;
  }

  void _showSnackBar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: mainAppBar(context: context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ref.watch(getCartsProvider).when(
                    data: (data) {
                      return data.isEmpty
                          ? Lottie.asset("assets/lotties/empty_cart.json")
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                carts = data;
                                var cart = data[index];
                                var product = products
                                    .where((element) =>
                                        element.productID == cart.productID)
                                    .first;

                                return Slidable(
                                    key: ValueKey(cart.cartID),
                                    direction: Axis.horizontal,
                                    closeOnScroll: true,
                                    endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        extentRatio: 0.2,
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              ref.watch(
                                                deleteCartProvider(cart.cartID),
                                              );
                                            },
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            foregroundColor: Theme.of(context)
                                                .colorScheme
                                                .onError,
                                            icon: Icons.delete,
                                          )
                                        ]),
                                    child: cartCard(
                                        context: context,
                                        cart: cart,
                                        ref: ref,
                                        productPrice: product.price));
                              },
                              separatorBuilder: (_, __) => 16.heightBox,
                              itemCount: data.length,
                            ).px(16);
                    },
                    error: (error, stackTrace) =>
                        ErrorText(error: error.toString()),
                    loading: () => const Loader(),
                  ),
            ),
            ref.watch(getCartsProvider).when(
                  data: (data) {
                    var t = 0;
                    for (CartModel cart in data) {
                      t = t + cart.totalExpense;
                    }
                    total = t;
                    return AnimatedContainer(
                      height: data.isEmpty ? 0 : 80,
                      width: context.percentWidth * 100,
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                          color: Theme.of(context).colorScheme.onBackground),
                      child: Visibility(
                        maintainState: true,
                        maintainAnimation: true,
                        visible: data.isEmpty ? false : true,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Total Product Expense: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                  ),
                                  AnimatedFlipCounter(
                                      value: total,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background),
                                      padding: const EdgeInsets.only(right: 1)),
                                ],
                              ),
                            ),
                            FilledButton(
                                onPressed: () {
                                  context.pushNamed(
                                    RouteConst.kCheckout,
                                    extra: carts,
                                  );
                                  ref
                                      .read(cartControllerProvider)
                                      .deleteAllCart();
                                },
                                child: const Text("Check Out"))
                          ],
                        ).px(16),
                      ),
                    );
                  },
                  error: (error, stackTrace) => Container(),
                  loading: () => Container(),
                )
          ],
        ),
      ),
    );
  }
}
