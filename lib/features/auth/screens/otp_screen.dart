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
    textStyle: GoogleFonts.poppins().copyWith(fontSize: 20),
    decoration: BoxDecoration(),
  );

  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
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
    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

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
                  Text(
                    "Verification",
                    style: GoogleFonts.josefinSans()
                        .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  50.heightBox,
                  Text(
                    "Enter the code sent to the number",
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 20,
                    ),
                  ),
                  10.heightBox,
                  Text(widget.phoneNumber),
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
            Center(
              child: Text(
                "Don't receive code?",
                style: GoogleFonts.poppins().copyWith(fontSize: 20),
              ),
            ),
            10.heightBox,
            TextButton(
                onPressed: () {},
                child: Text(
                  "Resend Code",
                  style: GoogleFonts.poppins()
                      .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ))
          ]),
    );
  }
}
