import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcean/core/common/error_text.dart';
import 'package:tcean/core/common/loader.dart';
import 'package:tcean/core/common/main_appBar.dart';
import 'package:tcean/features/explore/controller/offer_controller.dart';
import 'package:tcean/features/explore/widgets/best_selling_product.dart';
import 'package:tcean/features/explore/widgets/image_slider.dart';
import 'package:tcean/core/constants/route_const.dart';
import 'package:tcean/features/explore/widgets/offer_slider.dart';
import 'package:tcean/features/explore/widgets/trending.dart';
import 'package:tcean/features/products/controller/products_controller.dart';
import 'package:tcean/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/common/product_card.dart';
import '../../../core/common/telegram_button.dart';
import '../../../core/common/whatsapp_button.dart';

class ExploreScreen extends ConsumerWidget {
  ExploreScreen({Key? key}) : super(key: key);

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
    var showToast = Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? offersLength;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: mainAppBar(context: context,ref: ref),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            context.goNamed(RouteConst.kCustomize);
            // if (!await launchUrl(
            //   Uri.parse("https://wa.me/8801930132595"),
            //   mode: LaunchMode.externalApplication,
            // )) {
            //   throw Exception("can't launch for now");
            // }
          },
          label: const Text("Custom Your 👕"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: context.percentHeight * 5,
                    child: DefaultTextStyle(
                      style: GoogleFonts.poppins().copyWith(
                          fontSize: context.percentHeight * 3,
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
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
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              10.widthBox,
              SizedBox(
                height: context.percentHeight * 8,
                width: context.percentWidth * 100,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodySmall!,
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

              16.heightBox,

              //TODO: Offer Section

              ref.watch(getOffersProvider).when(
                    data: (data) {
                      if (data != null) {
                        offersLength = data.length;
                        return offersLength! > 0
                            ? InkWell(
                                radius: 16,
                                onTap: () {
                                  context.pushNamed(
                                    RouteConst.kOffer,
                                  );
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Today's Offers",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              context
                                                  .pushNamed(RouteConst.kOffer);
                                            },
                                            icon: const Icon(
                                                Icons.arrow_forward_ios)),
                                      ],
                                    ),
                                    offerSlider(context, data),
                                  ],
                                ),
                              )
                            : Container();
                      }
                      return Container();
                    },
                    error: (error, stackTrace) =>
                        ErrorText(error: error.toString()),
                    loading: () => const Loader(),
                  ),

              16.heightBox,

              //TODO: Special Section

              Text(
                "New Arrival",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: context.percentHeight * 40,
                width: context.percentWidth * 80,
                child: ref.watch(getProductsProvider).when(
                      data: (data) {
                        products = data;
                        // List<ProductModel> reverseProducts =
                        //     products.reversed.toList();
                        return AppinioSwiper(
                          loop: true,
                          cardsBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  RouteConst.kProductDetails,
                                  pathParameters: {
                                    "productID": products[index].productID
                                  },
                                  extra: products[index],
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CachedNetworkImage(
                                          key: UniqueKey(),
                                          imageUrl: products[index]
                                              .productImageUrls
                                              .first,
                                          placeholder: (context, url) =>
                                              const Text("tcean.store"),
                                          errorWidget: (context, url, error) =>
                                              const Text("tcean.store"),
                                        ),
                                      ),
                                    ),
                                    const Divider(thickness: 2),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              products[index].productName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                            ).pOnly(left: 16),
                                            Wrap(
                                              alignment: WrapAlignment.center,
                                              runAlignment:
                                                  WrapAlignment.center,
                                              children: products[index]
                                                  .categories
                                                  .map((e) => Text(
                                                        "#$e",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ).pOnly(left: 16))
                                                  .toList(),
                                            ).pOnly(bottom: 8)
                                          ],
                                        )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          cardsCount: products.length,
                        );
                      },
                      error: (error, stackTrace) => ErrorText(
                        error: error.toString(),
                      ),
                      loading: () => const Loader(),
                    ),
              ),
              16.heightBox,

              //TODO: Trendy Section
              16.heightBox,
              SizedBox(
                height: context.percentHeight * 24,
                width: context.percentWidth * 100,
                child: Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "Trendy",
                        style: GoogleFonts.poppins().copyWith(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: context.percentWidth * 40,
                            child: GestureDetector(
                              onTap: () {
                                context.pushNamed(RouteConst.kProductDetails,
                                    pathParameters: {
                                      "productID": trending(
                                              productModels: products)[index]
                                          .productID
                                    },
                                    extra: trending(
                                        productModels: products)[index]);
                              },
                              child: productCard(
                                  imageURL:
                                      trending(productModels: products)[index]
                                          .productImageUrls
                                          .first,
                                  productName:
                                      trending(productModels: products)[index]
                                          .productName),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => 8.widthBox,
                        itemCount: trending(productModels: products).length,
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
                height: context.percentHeight * 24,
                width: context.percentWidth * 100,
                child: Row(
                  children: [
                    Expanded(
                      child: ref.watch(getProductsProvider).when(
                            data: (data) => ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: context.percentWidth * 40,
                                  child: GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                        RouteConst.kProductDetails,
                                        pathParameters: {
                                          "productID": bestSellingProducts(
                                                  productModels: data)[index]
                                              .productID
                                        },
                                        extra: bestSellingProducts(
                                            productModels: data)[index],
                                      );
                                    },
                                    child: productCard(
                                        imageURL: bestSellingProducts(
                                                productModels: data)[index]
                                            .productImageUrls
                                            .first,
                                        productName: bestSellingProducts(
                                                productModels: data)[index]
                                            .productName),
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) => 8.widthBox,
                              itemCount:
                                  bestSellingProducts(productModels: data)
                                      .length,
                            ),
                            error: (error, stackTrace) =>
                                ErrorText(error: error.toString()),
                            loading: () => const Loader(),
                          ),
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        "Best Selling",
                        style: GoogleFonts.poppins().copyWith(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              //TODO: Contact Section
              const Divider(
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
                  const WhatsAppButton(),
                  16.widthBox,
                  const TelegramButton(),
                ],
              ),

              80.heightBox,
            ],
          ).px(16),
        ),
      ),
    );
  }
}
