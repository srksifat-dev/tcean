import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcean/dummy/dummy_offer.dart';
import 'package:tcean/features/explore/widgets/image_slider.dart';
import 'package:tcean/routes/route_const.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../dummy/dummy_product.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool _isBackPressed = false;
  Timer? _backButtonTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _backButtonTimer?.cancel();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (_isBackPressed) {
      // If already pressed once, exit the app
      return true;
    }

    _isBackPressed = true;
    _showSnackBar('Press back again to exit');

    _backButtonTimer = Timer(Duration(seconds: 2), () {
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.goNamed(RouteConst.kCustomize);
          },
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
                      style: GoogleFonts.poppins().copyWith(
                          fontSize: 30,
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
                height: context.percentHeight * 7,
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

              InkWell(
                radius: 16,
                onTap: () {
                  context.pushNamed(RouteConst.kOffer,
                      pathParameters: {"offerID": dummy_offer.offerID});
                },
                child: Card(
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
                              dummy_offer.title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            dummy_offer.subtitle.isNotEmptyAndNotNull
                                ? Text(
                                    dummy_offer.subtitle!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ).pOnly(left: 16, top: 16, bottom: 16),
                ),
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
                child: AppinioSwiper(
                    loop: true,
                    cardsBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(RouteConst.kProductDetails,
                              pathParameters: {
                                "productID": Dummy.products[index].productID
                              });
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
                                        Text(
                                          Dummy.products[index].productName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ).pOnly(left: 16),
                                        Row(
                                          children:
                                              Dummy.products[index].categories
                                                  .map((e) => Text(
                                                        "#$e",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ).pOnly(left: 16))
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
                                      "productID":
                                          Dummy.products[index].productID
                                    });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      Dummy.products[index].productImageUrls
                                          .first,
                                      height: context.percentHeight * 15,
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        8.widthBox,
                                        Expanded(
                                          child: Text(
                                              Dummy.products[index].productName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.favorite_border))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
                height: context.percentHeight * 24,
                width: context.percentWidth * 100,
                child: Row(
                  children: [
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
                                      "productID":
                                          Dummy.products[index].productID
                                    });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      Dummy.products[index].productImageUrls
                                          .first,
                                      height: context.percentHeight * 15,
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        8.widthBox,
                                        Expanded(
                                          child: Text(
                                              Dummy.products[index].productName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.favorite_border))
                                      ],
                                    )
                                  ],
                                ),
                              ),
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
                        style: GoogleFonts.poppins().copyWith(
                            fontSize: 25, fontWeight: FontWeight.bold),
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
                  GestureDetector(
                      onTap: () async {
                        if (!await launchUrl(
                          Uri.parse("https://wa.me/8801930132595"),
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception("can't launch for now");
                        }
                      },
                      child:
                          SvgPicture.asset("assets/images/whatsAppButton.svg")),
                  16.widthBox,
                  GestureDetector(
                      onTap: () async {
                        if (!await launchUrl(
                          Uri.parse("https://t.me/tcean"),
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception("can't launch for now");
                        }
                      },
                      child:
                          SvgPicture.asset("assets/images/telegramButton.svg")),
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
