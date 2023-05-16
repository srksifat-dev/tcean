import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../theme/app_colors.dart';
import '../controller/auth_controller.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen(this.phoneNumber, {Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: GoogleFonts.poppins().copyWith(color: AppColors.kSkyBlue),
    decoration: BoxDecoration(),
  );

  final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: AppColors.kSkyBlue,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );
  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: AppColors.kSkyBlue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: context.percentHeight * 40,
              child: Column(
                children: [
                  "Verification"
                      .text
                      .textStyle(Theme.of(context).textTheme.headlineLarge)
                      .makeCentered(),
                  50.heightBox,
                  "Enter the code sent to the number"
                      .text
                      .textStyle(Theme.of(context).textTheme.titleMedium)
                      .makeCentered(),
                  10.heightBox,
                  widget.phoneNumber.text.xl.bold
                      .color(AppColors.kSkyBlue)
                      .textStyle(Theme.of(context).textTheme.bodyMedium)
                      .xl3
                      .makeCentered(),
                ],
              ),
            ),
            Pinput(
              closeKeyboardWhenCompleted: true,
              listenForMultipleSmsOnAndroid: true,
              onClipboardFound: (value) => controller.text = value,
              autofocus: true,
              length: 5,
              pinAnimationType: PinAnimationType.slide,
              controller: controller,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              showCursor: true,
              cursor: cursor,
              preFilledWidget: preFilledWidget,
              // androidSmsAutofillMethod:
              //     AndroidSmsAutofillMethod.smsRetrieverApi,
              onCompleted: (_) {
                loginInfo.isLoggedIn = true;
              },
            ).pOnly(bottom: context.percentHeight * 30),
            "Don't receive code?"
                .text
                .textStyle(Theme.of(context).textTheme.bodyLarge)
                .makeCentered(),
            10.heightBox,
            TextButton(
                onPressed: () {},
                child: "Resend Code"
                    .text
                    .textStyle(Theme.of(context).textTheme.titleSmall)
                    .make())
          ]),
    );
  }
}
