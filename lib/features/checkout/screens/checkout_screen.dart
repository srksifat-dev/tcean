import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/core/common/editable_card.dart';
import 'package:tcean/core/common/phone_number_textfield.dart';
import 'package:tcean/dummy/dummy_address.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/common/checkout_textfield.dart';
import '../../../dummy/dummy_order.dart';
import '../../../models/user.dart';
import '../../../models/order_model.dart';
import '../../../core/constants/route_const.dart';
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
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  TextEditingController contactController = TextEditingController();
  FocusNode contactFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController districtController = TextEditingController();
  FocusNode districtFocusNode = FocusNode();
  TextEditingController areaController = TextEditingController();
  FocusNode areaFocusNode = FocusNode();
  TextEditingController detailsController = TextEditingController();
  FocusNode detailsFocusNode = FocusNode();
  GlobalKey<FormState> contactKey = GlobalKey<FormState>();
  late String name;
  late String contactNumber;
  late String email;

  String deliveryMethod = "Home Delivery";
  String address = dummyAddress.first.addressName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = dummyAccount.name!;
    contactNumber = dummyAccount.phoneNumber;
    email = dummyAccount.email!;
  }

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
                        subtitle: Text(
                          name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        icon: Icons.edit,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: CheckoutTextfield(
                                    controller: nameController,
                                    focusNode: nameFocusNode,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    textInputType: TextInputType.name,
                                    hintText: "Your Name",
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          GoRouter.of(context).pop();
                                        },
                                        child: Text("cancel")),
                                    FilledButton(
                                        onPressed: () {
                                          setState(() {
                                            name = nameController.text;
                                          });
                                          GoRouter.of(context).pop();
                                        },
                                        child: Text("Update")),
                                  ],
                                );
                              });
                        }),
                    editableCard(
                        context: context,
                        subtitle: Text(
                          contactNumber,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        icon: Icons.edit,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: PhoneNumberTextfield(
                                      controller: contactController,
                                      focusNode: contactFocusNode,
                                      formKey: contactKey),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          GoRouter.of(context).pop();
                                        },
                                        child: Text("cancel")),
                                    FilledButton(
                                        onPressed: () {
                                          if (contactKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              contactNumber =
                                                  contactController.text;
                                            });
                                            GoRouter.of(context).pop();
                                          }
                                        },
                                        child: Text("Update")),
                                  ],
                                );
                              });
                        }),
                    editableCard(
                        context: context,
                        subtitle: Text(
                          email,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        icon: Icons.edit,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: CheckoutTextfield(
                                    controller: emailController,
                                    focusNode: emailFocusNode,
                                    textCapitalization: TextCapitalization.none,
                                    textInputType: TextInputType.emailAddress,
                                    hintText: "Email Address",
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          GoRouter.of(context).pop();
                                        },
                                        child: Text("cancel")),
                                    FilledButton(
                                        onPressed: () {
                                          setState(() {
                                            email = emailController.text;
                                          });
                                          GoRouter.of(context).pop();
                                        },
                                        child: Text("Update")),
                                  ],
                                );
                              });
                        }),
                    editableCard(
                        context: context,
                        title: "Delivery Method",
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Radio(
                                    value: "Home Delivery",
                                    groupValue: deliveryMethod,
                                    onChanged: (val) {
                                      setState(() {
                                        deliveryMethod = val!;
                                      });
                                    }),
                                Text("Home Delivery"),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: "Sundarban Courier",
                                    groupValue: deliveryMethod,
                                    onChanged: (val) {
                                      setState(() {
                                        deliveryMethod = val!;
                                      });
                                    }),
                                Text("Sundarban Courier")
                              ],
                            ),
                          ],
                        ),
                        icon: Icons.local_shipping,
                        onTap: () {}),
                    editableCard(
                        context: context,
                        title: "Address",
                        subtitle: dummyAddress.isEmpty
                            ? TextButton.icon(
                                onPressed: () {
                                  showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CheckoutTextfield(
                                                      controller:
                                                          districtController,
                                                      focusNode:
                                                          districtFocusNode,
                                                      hintText: "District",
                                                      textInputType:
                                                          TextInputType.text,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                    ),
                                                    16.heightBox,
                                                    CheckoutTextfield(
                                                      controller:
                                                          areaController,
                                                      focusNode: areaFocusNode,
                                                      hintText:
                                                          "Area/Thana/Upozilla",
                                                      textInputType:
                                                          TextInputType.text,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                    ),
                                                    16.heightBox,
                                                    CheckoutTextfield(
                                                      controller:
                                                          detailsController,
                                                      focusNode:
                                                          detailsFocusNode,
                                                      hintText:
                                                          "Details Address",
                                                      textInputType:
                                                          TextInputType
                                                              .multiline,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        GoRouter.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("cancel")),
                                                  FilledButton(
                                                      onPressed: () {
                                                        GoRouter.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Update")),
                                                ],
                                              );
                                            });
                                },
                                icon: Icon(Icons.add_location_alt),
                                label: Text("Add Your Address"))
                            : Column(
                                children: [
                                  SizedBox(
                                    height: dummyAddress.length * 48,
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: dummyAddress.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Radio(
                                                  value: dummyAddress[index]
                                                      .addressName,
                                                  groupValue: address,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      address = val!;
                                                    });
                                                  }),
                                              Text(dummyAddress[index]
                                                  .addressName),
                                              Expanded(
                                                child: Text(
                                                  " (${dummyAddress[index].detailsAddress})",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                  TextButton.icon(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CheckoutTextfield(
                                                      controller:
                                                          districtController,
                                                      focusNode:
                                                          districtFocusNode,
                                                      hintText: "District",
                                                      textInputType:
                                                          TextInputType.text,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                    ),
                                                    16.heightBox,
                                                    CheckoutTextfield(
                                                      controller:
                                                          areaController,
                                                      focusNode: areaFocusNode,
                                                      hintText:
                                                          "Area/Thana/Upozilla",
                                                      textInputType:
                                                          TextInputType.text,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                    ),
                                                    16.heightBox,
                                                    CheckoutTextfield(
                                                      controller:
                                                          detailsController,
                                                      focusNode:
                                                          detailsFocusNode,
                                                      hintText:
                                                          "Details Address",
                                                      textInputType:
                                                          TextInputType
                                                              .multiline,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        GoRouter.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("cancel")),
                                                  FilledButton(
                                                      onPressed: () {
                                                        GoRouter.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Update")),
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.add_location_alt),
                                      label: Text("Add Your Address"))
                                ],
                              ),
                        icon: Icons.place,
                        onTap: () {}),
                  ],
                ),
                16.heightBox,

                //TODO: Discount

                Text("Discount"),
                Row(
                  children: [
                    Expanded(
                      child: CheckoutTextfield(controller: couponController, focusNode: couponFocusNode, textCapitalization: TextCapitalization.none, textInputType: TextInputType.text, hintText: "Enter Coupon Code"),
                    ),
                    8.widthBox,
                    FilledButton(onPressed: () {}, child: Text("Apply"))
                  ],
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
                      context.pushNamed(RouteConst.kPayment, pathParameters: {
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
