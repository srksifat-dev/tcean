import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/custom_textField.dart';
import 'otp_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();
  bool validity = false;
  String errorText = "";
  GlobalKey<FormState> contactKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneNumberController.text = "01";
    super.initState();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          phoneNumberFocusNode.unfocus();
        });
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Lottie.asset("assets/lotties/auth.json",
                width: context.percentWidth * 50),
            20.heightBox,
            "Phone Verification"
                .text
                .textStyle(Theme.of(context).textTheme.titleLarge)
                .align(TextAlign.center)
                .makeCentered(),
            "We need to register your phone before getting started!"
                .text
                .align(TextAlign.center)
                .textStyle(Theme.of(context).textTheme.bodyMedium)
                .makeCentered(),
            50.heightBox,
            Form(
              key: contactKey,
              child: kTextField(
                context: context,
                controller: phoneNumberController,
                focusNode: phoneNumberFocusNode,
                // cursorColor: AppColors.kSkyBlue,
                // textColor: AppColors.kBlue,
                hintText: "01XXXXXXXXX",
                maxLength: 11,
                textInputType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Mobile Number";
                  } else if (value.length != 11 ||
                      value.substring(0, 2) != "01" ||
                      value.substring(2, 3) == "2" ||
                      value.substring(2, 3) == "0") {
                    return "Please Enter valid mobile number";
                  }
                  return null;
                },
              ).px(50),
            ),
            20.heightBox,
            FilledButton(
                onPressed: () {
                  if (contactKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                OtpScreen(phoneNumberController.text)));
                    phoneNumberFocusNode.unfocus();
                  }
                },
                child: Text(
                  "Send OTP",
                  style: GoogleFonts.poppins()
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ],
        ).px(16),
      ),
    );
  }
}
