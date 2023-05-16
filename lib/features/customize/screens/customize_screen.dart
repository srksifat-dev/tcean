import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/t_colors.dart';
import '../../../common/t_sizes.dart';
import '../../../theme/app_colors.dart';

class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({Key? key}) : super(key: key);

  @override
  _CustomizeScreenState createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  PlatformFile? frontPickedFile;
  File? frontFile;
  PlatformFile? backPickedFile;
  File? backFile;
  PlatformFile? handPickedFile;
  File? handFile;
  int colorIndex = 0;
  int sizeIndex = 0;
  int quantity = 1;

  Future selectFrontFile() async {
    final result = await FilePicker.platform.pickFiles();
    setState(() {
      frontPickedFile = result!.files.first;
    });
    if (result != null) {
      frontFile = File(frontPickedFile!.path.toString());
    } else {
      return;
    }
  }

  Future selectBackFile() async {
    final result = await FilePicker.platform.pickFiles();
    setState(() {
      backPickedFile = result!.files.first;
    });
    if (result != null) {
      backFile = File(backPickedFile!.path.toString());
    } else {
      return;
    }
  }

  Future selectHandFile() async {
    final result = await FilePicker.platform.pickFiles();
    setState(() {
      handPickedFile = result!.files.first;
    });
    if (result != null) {
      handFile = File(handPickedFile!.path.toString());
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Your 👕"),
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
            child: Column(
              children: [
                16.heightBox,
                Text(
                  "Upload Design Files (required)",
                  style: GoogleFonts.josefinSans().copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.heightBox,
                frontPickedFile != null
                    ? SizedBox(
                        height: context.percentHeight * 5,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              frontPickedFile!.extension == "ai" ||
                                      frontPickedFile!.extension == "eps"
                                  ? SvgPicture.asset(
                                      "assets/images/illustrator_logo.svg",
                                      height: 30,
                                    ).px(16)
                                  : frontPickedFile!.extension == "psd"
                                      ? SvgPicture.asset(
                                          "assets/images/photoshop_logo.svg",
                                          height: 30,
                                        ).px(16)
                                      : SvgPicture.asset(
                                          "assets/images/image_icon.svg",
                                          height: 30,
                                        ).px(16),
                              Flexible(
                                child: Text(frontPickedFile!.name),
                              ),
                            ],
                          ),
                        ).px(16))
                    : Container(),
                4.heightBox,
                backPickedFile != null
                    ? SizedBox(
                        height: context.percentHeight * 5,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              backPickedFile!.extension == "ai" ||
                                      backPickedFile!.extension == "eps"
                                  ? SvgPicture.asset(
                                      "assets/images/illustrator_logo.svg",
                                      height: 30,
                                    ).px(16)
                                  : backPickedFile!.extension == "psd"
                                      ? SvgPicture.asset(
                                          "assets/images/photoshop_logo.svg",
                                          height: 30,
                                        ).px(16)
                                      : SvgPicture.asset(
                                          "assets/images/image_icon.svg",
                                          height: 30,
                                        ).px(16),
                              Flexible(
                                child: Text(backPickedFile!.name),
                              ),
                            ],
                          ),
                        ).px(16))
                    : Container(),
                4.heightBox,
                handPickedFile != null
                    ? Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            handPickedFile!.extension == "ai" ||
                                    handPickedFile!.extension == "eps"
                                ? SvgPicture.asset(
                                    "assets/images/illustrator_logo.svg",
                                    height: 30,
                                  ).px(16)
                                : handPickedFile!.extension == "psd"
                                    ? SvgPicture.asset(
                                        "assets/images/photoshop_logo.svg",
                                        height: 30,
                                      ).px(16)
                                    : SvgPicture.asset(
                                        "assets/images/image_icon.svg",
                                        height: 30,
                                      ).px(16),
                            Flexible(
                              child: Text(handPickedFile!.name),
                            ),
                          ],
                        ),
                      ).px(16)
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilledButton.icon(
                        onPressed: selectFrontFile,
                        icon: Icon(Icons.file_upload),
                        label: Text("Front")),
                    FilledButton.icon(
                        onPressed: selectBackFile,
                        icon: Icon(Icons.file_upload),
                        label: Text("Back")),
                    FilledButton.icon(
                        onPressed: selectHandFile,
                        icon: Icon(Icons.file_upload),
                        label: Text("Hand")),
                  ],
                ).py(8),
                Text(
                  "Illustrator (.ai, .eps) or Photoshop (.psd) files are preferred for good quality print.",
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.center,
                ).pOnly(bottom: 8),
              ],
            ),
          ).pOnly(left: 16, right: 16, bottom: 4),
          Card(
            child: Column(
              children: [
                Text(
                  "For Additional Information",
                  style: GoogleFonts.josefinSans().copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/whatsAppButton.svg"),
                    16.widthBox,
                    SvgPicture.asset("assets/images/telegramButton.svg"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Custom order ID:",
                      style: GoogleFonts.poppins().copyWith(fontSize: 15),
                    ),
                    Text(
                      "CO-123456",
                      style: GoogleFonts.poppins()
                          .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.copy)),
                  ],
                ),
              ],
            ).pOnly(top: 16, left: 16, right: 16),
          ).pOnly(top: 4, left: 16, right: 16, bottom: 4),
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
                                            message: kTColors[index].toString(),
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: colorIndex != index
                                                          ? kTColors[index]
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
                                  children: kTSizes
                                      .map(
                                        (e) => e.text.make(),
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
                            quantity.toString().text.make(),
                            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                          ],
                        ).px(16),
                        SwipeButton(
                            borderRadius: BorderRadius.circular(16),
                            // activeThumbColor: AppColors.kTertiary,
                            // inactiveThumbColor: AppColors.kSecondary,
                            child: "Buy Now"
                                .text
                                .bold
                                .makeCentered()
                                .pOnly(left: 16))
                      ],
                    ),
                  ),
                ),
              ],
            ).pSymmetric(h: 16),
          ).py(8),
        ],
      ),
    );
  }
}
