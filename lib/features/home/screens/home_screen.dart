import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcean/features/home/widgets/image_slider.dart';
import 'package:tcean/theme/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../dummy copy/dummy_product.dart';
import '../../shop/screens/product_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Custom Your 👕"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: context.percentHeight * 5,
                  child: DefaultTextStyle(
                    style: GoogleFonts.poppins()
                        .copyWith(fontSize: 30, color: AppColors.kOceanLight),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        RotateAnimatedText(
                          'Trendy✨',
                        ),
                        RotateAnimatedText(
                          'Smart😎',
                        ),
                        RotateAnimatedText(
                          'Customized✏',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Welcome to the ocean of tees",
              style: GoogleFonts.josefinSans().copyWith(
                color: AppColors.kBlue,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            10.widthBox,
            SizedBox(
              height: context.percentHeight * 6,
              width: context.percentWidth * 100,
              child: Flexible(
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyLarge!,
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                          "Fashion is a form of self-expression and we are here for you to help you to express yourself!",
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
              ),
            ),

            16.heightBox,

            //TODO: Category Section
            SizedBox(
              height: 100,
              width: context.percentWidth * 100,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.category,
                            size: 30,
                          ).p(20),
                        ),
                        Text("All"),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    indent: 16,
                    endIndent: 16,
                    thickness: 2,
                  ),
                  Expanded(
                      flex: 4,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Icons.category,
                                      size: 30,
                                    ).p(20),
                                  ),
                                  Text("All"),
                                ],
                              ),
                          separatorBuilder: (_, __) => 16.widthBox,
                          itemCount: 10)),
                ],
              ),
            ),

            16.heightBox,

            //TODO: Special Section

            Text(
              "New Arrival",
              style: GoogleFonts.josefinSans()
                  .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: context.percentHeight * 40,
              width: context.percentWidth * 80,
              child: AppinioSwiper(
                  loop: true,
                  cardsBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                    productID: Dummy.products[index].productID
                                        .toString())));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Image.asset(Dummy
                                      .products[index].productImageUrls.first)
                                  .p(16),
                            ),
                            Divider(thickness: 2),
                            SizedBox(
                              width: context.percentWidth * 100,
                              height: context.percentHeight * 7,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Dummy.products[index].productName.text
                                          .textStyle(Theme.of(context)
                                              .textTheme
                                              .titleMedium)
                                          .make()
                                          .pOnly(left: 16),
                                      Row(
                                        children: Dummy
                                            .products[index].categories
                                            .map((e) => "#$e"
                                                .text
                                                .textStyle(Theme.of(context)
                                                    .textTheme
                                                    .bodySmall)
                                                .make()
                                                .pOnly(left: 16))
                                            .toList(),
                                      )
                                    ],
                                  )),
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite_border)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  cardsCount: Dummy.products.length),
            ),
            16.heightBox,

            //TODO: Offer Section

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(
                      Icons.sell,
                      size: 50,
                    ),
                  ),
                  16.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "50% OFF",
                          style: GoogleFonts.josefinSans().copyWith(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "for all Men's T-shirts",
                          style: GoogleFonts.poppins(),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                ],
              ).pOnly(left: 16, top: 16, bottom: 16),
            ),

            //TODO: Trendy Section
            16.heightBox,
            SizedBox(
              height: 160,
              width: context.percentWidth * 100,
              child: Row(
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "Trendy",
                      style: GoogleFonts.poppins()
                          .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Image.asset(
                            Dummy.products[index].productImageUrls.first,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => 8.widthBox,
                      itemCount: Dummy.products.length,
                    ),
                  ),
                ],
              ),
            ),

            //TODO: Image Slider
            16.heightBox,
            imgSlider(),

            //TODO: Best Selling Section
            16.heightBox,
            SizedBox(
              height: 160,
              width: context.percentWidth * 100,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Image.asset(
                            Dummy.products[index].productImageUrls.first,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => 8.widthBox,
                      itemCount: Dummy.products.length,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      "Best Selling",
                      style: GoogleFonts.poppins()
                          .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            //TODO: Contact Section
            Divider(
              thickness: 2,
            ),
            Text(
              "Contact With Us",
              style: GoogleFonts.poppins().copyWith(fontSize: 20),
            ),
            16.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/whatsAppButton.svg"),
                16.widthBox,
                SvgPicture.asset("assets/images/telegramButton.svg"),
              ],
            ),

            80.heightBox,
          ],
        ).px(16),
      ),
    );
  }
}
