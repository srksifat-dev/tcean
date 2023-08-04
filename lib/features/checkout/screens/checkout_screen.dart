import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/core/common/editable_card.dart';
import 'package:tcean/core/common/phone_number_textfield.dart';
import 'package:tcean/models/cart_model.dart';
import 'package:tcean/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/common/checkout_textfield.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../main.dart';
import '../../../models/address_model.dart';
import '../../../models/coupon_model.dart';
import '../../../models/order_model.dart';
import '../../../core/constants/route_const.dart';
import '../../auth/controller/auth_controller.dart';
import '../../explore/controller/offer_controller.dart';
import '../../order/widgets/order_item_card.dart';
import '../../order/widgets/order_item_slider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({
    Key? key,
    required this.carts,
  }) : super(key: key);
  final List<CartModel> carts;

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  TextEditingController couponController = TextEditingController();
  FocusNode couponFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  TextEditingController contactController = TextEditingController();
  FocusNode contactFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController addressNameController = TextEditingController();
  FocusNode addressNameFocusNode = FocusNode();
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

  List<AddressModel> _addressList = [];

  int deliveryMethodIndex = 0;

  List<AddressModel> reversedList = [];
  int selectedAddressIndex = 0;
  int total = 0;
  int discountedTotal = 0;
  int deliveryCharge = 60;

  bool isTotalExpenseDiscounted = false;
  bool isDeliveryChargeDiscounted = false;
  bool isQuantityDiscounted = false;

  bool readOnly = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = userModel!.name ?? "Receiver Name";
    contactNumber = userModel!.phoneNumber ?? "01XXXXXXXXX";
    email = userModel!.email!;
    int t = 0;
    for (CartModel cart in widget.carts) {
      t = t + (cart.totalExpense);
    }
    total = t;
  }

  @override
  Widget build(BuildContext context) {
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
                Text(
                  "Ordered Products",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                orderItemSlider(
                    orderItemCards: widget.carts
                        .map((e) => orderItemCard(context: context, cart: e))
                        .toList()),
                16.heightBox,

                //TODO: Receiver info
                Text(
                  "Receiver Information",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    editableCard(
                      context: context,
                      sectionTitle: "Name",
                      title: Text(
                        name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
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
                                        child: const Text("cancel")),
                                    FilledButton(
                                        onPressed: () {
                                          setState(() {
                                            name = nameController.text;
                                          });
                                          GoRouter.of(context).pop();
                                        },
                                        child: const Text("Update")),
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                    editableCard(
                      context: context,
                      sectionTitle: "Contact Number",
                      title: Text(
                        contactNumber,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
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
                                        child: const Text("cancel")),
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
                                        child: const Text("Update")),
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                    editableCard(
                      context: context,
                      sectionTitle: "Email Address",
                      title: Text(
                        email,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
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
                                        child: const Text("cancel")),
                                    FilledButton(
                                        onPressed: () {
                                          setState(() {
                                            email = emailController.text;
                                          });
                                          GoRouter.of(context).pop();
                                        },
                                        child: const Text("Update")),
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                    16.heightBox,
                    editableCard(
                      context: context,
                      sectionTitle: "Choice Delivery Method",
                      sectionTileTextStyle:
                          Theme.of(context).textTheme.titleSmall,
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Radio(
                                  value: deliveryMethods[0],
                                  groupValue:
                                      deliveryMethods[deliveryMethodIndex],
                                  onChanged: (val) {
                                    setState(() {
                                      deliveryMethodIndex = deliveryMethods
                                          .indexOf(val.toString());
                                    });
                                  }),
                              const Text("Home Delivery"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: deliveryMethods[1],
                                  groupValue:
                                      deliveryMethods[deliveryMethodIndex],
                                  onChanged: (val) {
                                    setState(() {
                                      deliveryMethodIndex = deliveryMethods
                                          .indexOf(val.toString());
                                    });
                                  }),
                              const Text("Sundarban Courier")
                            ],
                          ),
                        ],
                      ),
                    ),
                    16.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Choice Shipping Address",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        TextButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CheckoutTextfield(
                                          controller: addressNameController,
                                          focusNode: addressNameFocusNode,
                                          hintText: "Address Name(Ex. Home)",
                                          textInputType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.words,
                                        ),
                                        16.heightBox,
                                        CheckoutTextfield(
                                          controller: districtController,
                                          focusNode: districtFocusNode,
                                          hintText: "District",
                                          textInputType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.words,
                                        ),
                                        16.heightBox,
                                        CheckoutTextfield(
                                          controller: areaController,
                                          focusNode: areaFocusNode,
                                          hintText: "Area/Thana/Upozilla",
                                          textInputType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.words,
                                        ),
                                        16.heightBox,
                                        CheckoutTextfield(
                                          controller: detailsController,
                                          focusNode: detailsFocusNode,
                                          hintText: "Details Address",
                                          textInputType:
                                              TextInputType.multiline,
                                          textCapitalization:
                                              TextCapitalization.words,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            GoRouter.of(context).pop();
                                          },
                                          child: const Text("cancel")),
                                      FilledButton(
                                          onPressed: () {
                                            ref
                                                .watch(authControllerProvider
                                                    .notifier)
                                                .addAddress(
                                                  uid: userModel!.uid,
                                                  address: AddressModel(
                                                    addressName:
                                                        addressNameController
                                                            .text,
                                                    district:
                                                        districtController.text,
                                                    area: areaController.text,
                                                    detailsAddress:
                                                        detailsController.text,
                                                    defaultIndex:
                                                        _addressList.length,
                                                  ),
                                                );
                                            GoRouter.of(context).pop();
                                          },
                                          child: const Text("Add")),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.add_location_alt),
                          label: const Text("Add"),
                        )
                      ],
                    ),
                    ref.watch(getAddressesProvider(userModel!.uid)).when(
                          data: (addresses) {
                            reversedList = addresses.reversed.toList();
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: reversedList
                                    .map((e) => Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: RadioListTile(
                                            title: Text(
                                              e.addressName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                            subtitle: Text(
                                              "${e.detailsAddress}, ${e.area}, ${e.district}",
                                            ),
                                            value: reversedList.indexOf(e),
                                            groupValue: selectedAddressIndex,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedAddressIndex = value!;
                                              });
                                            },
                                          ),
                                        ))
                                    .toList(),
                              ),
                            );
                          },
                          error: (error, stackTrace) =>
                              ErrorText(error: error.toString()),
                          loading: () => const Loader(),
                        ),
                  ],
                ),
                16.heightBox,

                //TODO: Discount

                Text(
                  "Discount Nite Chaile",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckoutTextfield(
                          controller: couponController,
                          focusNode: couponFocusNode,
                          readOnly: readOnly,
                          textCapitalization: TextCapitalization.none,
                          textInputType: TextInputType.text,
                          hintText: "Enter Coupon Code"),
                    ),
                    8.widthBox,
                    readOnly ? Container(): FilledButton(
                        onPressed: () {
                          int tExpense = 0;
                          for (CartModel cart in widget.carts) {

                            ref.watch(getOffersProvider).when(
                                data: (coupons) {
                                  if (coupons != null) {
                                    for (CouponModel coupon in coupons) {
                                      // Verify Coupon code
                                      if (coupon.couponCode ==
                                          couponController.text) {
                                        switch (coupon.couponType) {
                                          case "moneyDiscount":
                                            switch (coupon.applyTo) {
                                              case "All Products":
                                                //Do something
                                                tExpense = tExpense +
                                                    cart.totalExpense -
                                                    (coupon.discountAmount! *
                                                            cart.quantity)
                                                        .toInt();
                                                break;
                                              case "Specific Product":
                                                //Do Something
                                                var p = products
                                                    .where((element) =>
                                                        element.productName ==
                                                        coupon.productName)
                                                    .first;
                                                if (cart.productID ==
                                                    p.productID) {
                                                  tExpense = tExpense +
                                                      cart.totalExpense -
                                                      (coupon.discountAmount! *
                                                          cart.quantity);
                                                }
                                                break;
                                              case "Specific Category":
                                                //DO Something

                                                break;
                                              case "Minimum Order Subtotal":
                                                //Do Something
                                                if (total >=
                                                    coupon.minimumOrder!) {
                                                  tExpense = tExpense +
                                                      cart.totalExpense -
                                                      (coupon.discountAmount! *
                                                          cart.quantity);
                                                }

                                                break;
                                            }
                                            break;
                                          case "percentDiscount":
                                            switch (coupon.applyTo) {
                                              case "All Products":
                                                //Do Something
                                                tExpense = tExpense +
                                                    cart.totalExpense -
                                                    (cart.totalExpense *
                                                            (coupon.discountPercent! /
                                                                100))
                                                        .toInt();
                                                break;
                                              case "Specific Product":
                                                //Do something
                                                var p = products
                                                    .where((element) =>
                                                        element.productName ==
                                                        coupon.productName)
                                                    .first;
                                                if (cart.productID ==
                                                    p.productID) {
                                                  tExpense = tExpense +
                                                      cart.totalExpense -
                                                      (cart.totalExpense *
                                                              (coupon.discountPercent! /
                                                                  100))
                                                          .toInt();
                                                }
                                                break;
                                              case "Specific Category":
                                                //Do Something
                                                break;
                                              case "Minimum Order Subtotal":
                                                //DO SOmething
                                                if (total >=
                                                    coupon.minimumOrder!) {
                                                  tExpense = tExpense +
                                                      cart.totalExpense -
                                                      (cart.totalExpense *
                                                              (coupon.discountPercent! /
                                                                  100))
                                                          .toInt();
                                                }
                                                break;
                                            }
                                            break;
                                          case "freeShipping":
                                            switch (coupon.applyTo) {
                                              case "All Orders":
                                                //DO something
                                                deliveryCharge = 0;
                                                break;
                                              case "Minimum Order Subtotal":
                                                //Do Something
                                                if (total >=
                                                    coupon.minimumOrder!) {
                                                  deliveryCharge = 0;
                                                }
                                                break;
                                            }
                                            break;
                                          case "salePrice":
                                            switch (coupon.applyTo) {
                                              case "All Products":
                                                //Do Something
                                                tExpense = tExpense +
                                                    coupon.salePrice! *
                                                        cart.quantity;
                                                break;
                                              case "Specific Product":
                                                //Do Something
                                                var p = products
                                                    .where((element) =>
                                                        element.productName ==
                                                        coupon.productName)
                                                    .first;
                                                if (cart.productID ==
                                                    p.productID) {
                                                  tExpense = tExpense +
                                                      (coupon.salePrice! *
                                                          cart.quantity);
                                                }
                                                break;
                                              case "Specific Category":
                                                //Do Something
                                                break;
                                            }
                                            break;
                                          case "buyXGetYFree":
                                            switch (coupon.applyTo) {
                                              case "All Products":
                                                //Do SOmething
                                                if (cart.quantity >=
                                                    coupon.buyQuantity!) {
                                                  cart.quantity =
                                                      cart.quantity +
                                                          coupon.getQuantity!;
                                                }
                                                break;
                                              case "Specific Product":
                                                //Do SOmething
                                                var p = products
                                                    .where((element) =>
                                                        element.productName ==
                                                        coupon.productName)
                                                    .first;
                                                if (cart.productID ==
                                                    p.productID) {
                                                  if (cart.quantity >=
                                                      coupon.buyQuantity!) {
                                                    cart.quantity =
                                                        cart.quantity +
                                                            coupon.getQuantity!;
                                                  }
                                                }
                                                break;
                                              case "Specific Category":
                                                //Do Something
                                                break;
                                            }
                                            break;
                                          default:
                                        }
                                      }
                                    }
                                  } else {
                                    return 0;
                                  }
                                },
                                error: (error, stackTrace) =>
                                    ErrorText(error: error.toString()),
                                loading: () => const Loader());
                            discountedTotal = tExpense;
                            setState(() {});
                          }
                        },
                        child: const Text("Apply"))
                  ],
                ),
                16.heightBox,

                //TODO: Calculator
                Text(
                  "Total Payment",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Product Expense:"),
                          Text("৳ $total"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Delivery Expense:"),
                          Text("৳ $deliveryCharge"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Discount:"),
                          discountedTotal != 0
                              ? Text("- ৳ ${total - discountedTotal}")
                              : const Text("- ৳ 0"),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ).px(16),
          )),
          Container(
            height: 100,
            width: context.percentWidth * 100,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
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
                            discountedTotal != 0
                                ? TextSpan(
                                    text: "${discountedTotal + deliveryCharge}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
                                  )
                                : TextSpan(
                                    text: "${total + deliveryCharge}",
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
                            discountedTotal != 0
                                ? TextSpan(
                                    text: "${discountedTotal + deliveryCharge}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
                                  )
                                : TextSpan(
                                    text: "${total + deliveryCharge}",
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
                              text: "0",
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
                      context.pushNamed(RouteConst.kPayment);
                      readOnly = true;
                    },
                    child: const Text("Pay Now"))
              ],
            ).px(16),
          ),
        ],
      ),
    );
  }
}
