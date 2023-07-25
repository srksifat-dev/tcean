import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcean/dummy/dummy_product.dart';
import 'package:tcean/features/products/controller/products_controller.dart';
import 'package:tcean/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../models/t_color.dart';
import '../../../models/t_size.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final String productID;
  const ProductDetailsScreen({Key? key, required this.productID})
      : super(key: key);

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  int colorIndex = 0;
  int sizeIndex = 0;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_shopping_cart),
      ),
      body: StreamBuilder(
          stream:
              ref.watch(productControllerProvider).getProduct(widget.productID),
          builder: (context, snapshot) {
            print(snapshot);
            return snapshot.hasData
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: CachedNetworkImage(
                              key: UniqueKey(),
                              imageUrl: snapshot.data!.productImageUrls.first,
                              placeholder: (context, url) =>
                                  Text("tcean.store"),
                              errorWidget: (context, url, error) =>
                                  Text("tcean.store"),
                            ),
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
                                    snapshot.data!.productName,
                                    style: GoogleFonts.josefinSans().copyWith(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: snapshot.data!.categories
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
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Colors",
                                              style: GoogleFonts.josefinSans()
                                                  .copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                                height: 30,
                                                child: ListView.separated(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            colorIndex = index;
                                                          });
                                                        },
                                                        child: Tooltip(
                                                          message:
                                                              kColors[index]
                                                                  .colorName,
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    width: 2,
                                                                    color: colorIndex !=
                                                                            index
                                                                        ? Color(kColors[index]
                                                                            .colorCode)
                                                                        : Colors
                                                                            .transparent),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                color: colorIndex ==
                                                                        index
                                                                    ? Color(kColors[
                                                                            index]
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
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Size",
                                              style: GoogleFonts.josefinSans()
                                                  .copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  context.percentHeight * 6.5,
                                              child: CupertinoPicker(
                                                itemExtent: 25,
                                                onSelectedItemChanged:
                                                    (selectedSizeIndex) {
                                                  setState(
                                                    () {
                                                      sizeIndex =
                                                          selectedSizeIndex;
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      16.heightBox,
                                      Text(
                                        "Total Expense",
                                        style:
                                            GoogleFonts.josefinSans().copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("(৳ 300",
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
                                                fontSize: 20,
                                              )),
                                          Text("x",
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
                                                fontSize: 20,
                                              )),
                                          Text("1)",
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
                                                fontSize: 20,
                                              )),
                                        ],
                                      ),
                                      Text("৳ 300",
                                          style: GoogleFonts.josefinSans()
                                              .copyWith(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.remove)),
                                          Text(
                                            quantity.toString(),
                                            style: GoogleFonts.poppins(),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.add)),
                                        ],
                                      ).px(16),
                                      SwipeButton(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          // activeThumbColor: AppColors.kTertiary,
                                          // inactiveThumbColor: AppColors.kSecondary,
                                          child: Text(
                                            "Buy Now",
                                            style: GoogleFonts.poppins()
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ))
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
                  )
                : Center(
                    child: Text("There is no product to show!"),
                  );
          }),
    );
  }
}
