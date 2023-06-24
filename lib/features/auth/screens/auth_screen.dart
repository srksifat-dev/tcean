import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:tcean/features/auth/controller/auth_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/lotties/auth.json",
            width: context.percentWidth * 50,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Just one touch ahead to get in ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextSpan(
                  text: "tcean",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Color(0xff2F7FED),
                      ),
                ),
              ],
            ),
          ),
          64.heightBox,
          InkWell(
            onTap: () {
              setState(() {
                isTapped = true;
              });
              AuthController.signInWithGoogle().then((_) {
                setState(() {
                  isTapped = false;
                });
              });
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: isTapped
                  ? CircularProgressIndicator(
                      strokeWidth: 5,
                    ).p(16)
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.google,
                          size: 32,
                        ),
                        8.widthBox,
                        Text("Sign in with Google"),
                      ],
                    ).p(16),
            ),
          ),
        ],
      ).px(16),
    );
  }
}
