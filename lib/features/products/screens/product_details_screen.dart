import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:go_router/go_router.dart' as go;
import 'package:google_fonts/google_fonts.dart';
import 'package:tcean/core/constants/route_const.dart';
import 'package:tcean/features/cart/controller/cart_controller.dart';
import 'package:tcean/models/cart_model.dart';
import 'package:tcean/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../models/t_color.dart';
import '../../../models/t_size.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final String productID;
  final ProductModel product;
  const ProductDetailsScreen({
    Key? key,
    required this.productID,
    required this.product,
  }) : super(key: key);

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  int colorIndex = 0;
  int sizeIndex = 0;
  int quantity = 1;

  final quill.QuillController _controller = quill.QuillController.basic();

  @override
  void initState() {
    _controller.document = quill.Document.fromDelta(widget.product.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Product Details"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            ref.watch(addCartProvider(CartModel(
                cartID: DateTime.now().toString().trim(),
                color: kColors[colorIndex].colorName,
                productID: widget.productID,
                quantity: quantity,
                size: kSizes[sizeIndex].size,
                totalExpense: widget.product.price * quantity)));
          },
          child: const Icon(Icons.add_shopping_cart),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    aspectRatio: 1,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                  ),
                  items: widget.product.productImageUrls
                      .map((item) => Center(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: CachedNetworkImage(
                                key: UniqueKey(),
                                imageUrl: item,
                                fit: BoxFit.fitHeight,
                                height: double.infinity,
                                placeholder: (context, url) =>
                                    const Text("tcean.store"),
                                errorWidget: (context, url, error) =>
                                    const Text("tcean.store"),
                              ),
                            ),
                          )))
                      .toList(),
                ),
              ).px(16),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.productName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: widget.product.categories
                              .map((e) => Text("#$e "))
                              .toList(),
                        )
                      ],
                    ).pOnly(top: 16, bottom: 16, left: 16),

                    //TODO: Favourite selection functionality
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.favorite_border,
                    //       size: 32,
                    //     ))
                  ],
                ),
              ).pSymmetric(h: 16, v: 8),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      "Product Info",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    childrenPadding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    collapsedIconColor:
                        Theme.of(context).colorScheme.onBackground,
                    iconColor: Theme.of(context).colorScheme.onBackground,
                    children: [
                      quill.QuillEditor.basic(
                        controller: _controller,
                        readOnly: true,
                        autoFocus: false,
                      ),
                    ],
                  ),
                ),
              ).px(16),
              SizedBox(
                height: context.percentHeight * 30,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Colors",
                                    style: GoogleFonts.josefinSans().copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      height: 30,
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  colorIndex = index;
                                                });
                                              },
                                              child: Tooltip(
                                                message:
                                                    kColors[index].colorName,
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2,
                                                          color: colorIndex !=
                                                                  index
                                                              ? Color(
                                                                  kColors[index]
                                                                      .colorCode)
                                                              : Colors
                                                                  .transparent),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: colorIndex == index
                                                          ? Color(kColors[index]
                                                              .colorCode)
                                                          : null),
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (_, __) =>
                                              10.widthBox,
                                          itemCount: kColors.length))
                                ],
                              ).p(16),
                            ),
                          ),
                          10.heightBox,
                          Expanded(
                            flex: 1,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Size",
                                    style: GoogleFonts.josefinSans().copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: context.percentHeight * 6.5,
                                    child: CupertinoPicker(
                                      itemExtent: 25,
                                      onSelectedItemChanged:
                                          (selectedSizeIndex) {
                                        setState(
                                          () {
                                            sizeIndex = selectedSizeIndex;
                                          },
                                        );
                                      },
                                      children: kSizes
                                          .map(
                                            (e) => e.size.text.make(),
                                          )
                                          .toList(),
                                    ),
                                  )
                                ],
                              ).p(16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.widthBox,
                    Expanded(
                      flex: 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            16.heightBox,
                            Text(
                              "Total Expense",
                              style: GoogleFonts.josefinSans().copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("(৳ ${widget.product.price}",
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 20,
                                    )),
                                Text("x",
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 20,
                                    )),
                                AnimatedFlipCounter(
                                  value: quantity,
                                  suffix: ")",
                                )
                              ],
                            ),
                            AnimatedFlipCounter(
                              value: widget.product.price * quantity,
                              prefix: "৳ ",
                              textStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              padding: const EdgeInsets.only(right: 2),
                            ),
                            // Text("৳ ${widget.product.price * quantity}",
                            //     style: GoogleFonts.josefinSans().copyWith(
                            //       fontSize: 40,
                            //       fontWeight: FontWeight.bold,
                            //     )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.remove)),
                                AnimatedFlipCounter(value: quantity),
                                // Text(
                                //   quantity.toString(),
                                //   style: GoogleFonts.poppins(),
                                // ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    icon: const Icon(Icons.add)),
                              ],
                            ).px(16),
                            SwipeButton(
                              onSwipeEnd: () {
                                List<CartModel> carts = [];
                                CartModel cart = CartModel(
                                    cartID: DateTime.now().toString().trim(),
                                    color: kColors[colorIndex].colorName,
                                    productID: widget.productID,
                                    quantity: quantity,
                                    size: kSizes[sizeIndex].size,
                                    totalExpense:
                                        widget.product.price * quantity);
                                carts.add(cart);
                                go.GoRouter.of(context).push(
                                  "/${RouteConst.kCart}/${RouteConst.kCheckout}",
                                  extra: carts,
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              // activeThumbColor: AppColors.kTertiary,
                              // inactiveThumbColor: AppColors.kSecondary,
                              child: Text(
                                "Checkout",
                                style: GoogleFonts.poppins()
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).pSymmetric(h: 16),
              ).pOnly(top: 8, bottom: 80),

              //TODO: Custom the product
              // FilledButton(
              //     onPressed: () {},
              //     child: Text(
              //       "Custom it",
              //       style: GoogleFonts.poppins()
              //           .copyWith(fontWeight: FontWeight.bold),
              //     )),
            ],
          ),
        ));
  }
}
