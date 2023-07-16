import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcean/dummy/dummy_product.dart';
import 'package:tcean/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/common/t_colors.dart';
import '../../../core/common/t_sizes.dart';
import '../../../models/t_color.dart';
import '../../../models/t_size.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productID;
  const ProductDetailsScreen({Key? key, required this.productID})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int colorIndex = 0;
  int sizeIndex = 0;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    print(GoRouterState.of(context).fullPath);
    final ProductModel product = Dummy.products
        .where(
          (element) => element.productID == widget.productID,
        )
        .first;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_shopping_cart),
      ),
      body: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Image.asset(
              product.productImageUrls.first,
              width: context.percentWidth * 70,
            ),
          ).px(16),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      style: GoogleFonts.josefinSans()
                          .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children:
                          product.categories.map((e) => Text("#$e ")).toList(),
                    )
                  ],
                ).pOnly(top: 16, bottom: 16, left: 16),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      size: 32,
                    ))
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
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            message: kColors[index].colorName,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: colorIndex != index
                                                          ? Color(kColors[index]
                                                              .colorCode)
                                                          : Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: colorIndex == index
                                                      ? kTColors[index]
                                                      : null),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (_, __) => 10.widthBox,
                                      itemCount: kTColors.length))
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  onSelectedItemChanged: (selectedSizeIndex) {
                                    setState(
                                      () {
                                        sizeIndex = selectedSizeIndex;
                                      },
                                    );
                                  },
                                  children: kSizes
                                      .map(
                                        (e) => e.sizeName.text.make(),
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
                            Text("(৳ 300",
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 20,
                                )),
                            Text("x",
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 20,
                                )),
                            Text("1)",
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 20,
                                )),
                          ],
                        ),
                        Text("৳ 300",
                            style: GoogleFonts.josefinSans().copyWith(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.remove)),
                            Text(
                              quantity.toString(),
                              style: GoogleFonts.poppins(),
                            ),
                            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                          ],
                        ).px(16),
                        SwipeButton(
                            borderRadius: BorderRadius.circular(16),
                            // activeThumbColor: AppColors.kTertiary,
                            // inactiveThumbColor: AppColors.kSecondary,
                            child: Text(
                              "Buy Now",
                              style: GoogleFonts.poppins()
                                  .copyWith(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ).pSymmetric(h: 16),
          ).py(8),
          FilledButton(
              onPressed: () {},
              child: Text(
                "Custom it",
                style:
                    GoogleFonts.poppins().copyWith(fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
